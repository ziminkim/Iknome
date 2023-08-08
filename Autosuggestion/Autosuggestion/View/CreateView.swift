//
//  CreateView.swift
//  Autosuggestion
//
//  Created by 김지민 on 2023/07/14.
//

import SwiftUI
import CoreData

struct CreateView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.dismiss) var dismiss //go back
    
    @State private var name = ""
    @State private var memo = ""
 
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                TextField("제목", text: $name)
                    .padding(6)
                    .font(.title)
                //여러 줄 입력 위해
                Rectangle().frame(height: 0.5).foregroundColor(.gray)
                TextEditor(text: $memo)
                    .frame(height: 600) // 일단,, 이렇게 하고 테스트
                    .padding(6)
                    .font(.body)
                
                Spacer()
                
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("저장") {
                        DataController().addMemento(name: name, memo: memo, context: managedObjectContext)
                        dismiss()
                    }

                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("취소") {
                        dismiss()
                    }

                }
            }

        }.padding()
        
    }
}

struct CreateView_Previews: PreviewProvider {
    static var previews: some View {
        CreateView()
    }
}
