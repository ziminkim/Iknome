//
//  DataController.swift
//  Autosuggestion
//
//  Created by 김지민 on 2023/07/17.
//

import Foundation
import CoreData

class DataController : ObservableObject {
    
    let container = NSPersistentContainer(name: "Autosuggestion")
    
    //class must be inited
    init() {
        container.loadPersistentStores { desc, error in
            if let error = error {
                print("Fail to load data \(error.localizedDescription)")
            }
            
        }
    }
    
    //func...
    
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
            print("Data Saved!")
        } catch {
            print("We could not save the data")
        }
    }
    
    //우선 이름이랑 메모
    func addMemento(name: String, memo: String, context: NSManagedObjectContext) {
        let memento = Item(context: context)
        memento.id = UUID()
        memento.date = Date()
        if name != "" {memento.name = name} else {memento.name = "제목 없음"}
        if memo != "" {memento.memo = memo} else {memento.memo = "메모 없음"}
        
        save(context: context)
    }
    
    func editMemento(memento: Item, name: String, memo: String, context: NSManagedObjectContext){
        memento.name = name
        memento.memo = memo
        memento.date = Date()
        
        save(context: context)
    }
    

}
