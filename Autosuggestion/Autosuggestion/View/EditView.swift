//
//  EditView.swift
//  Autosuggestion
//
//  Created by 김지민 on 2023/07/27.
//

import SwiftUI

struct EditView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    var memento: FetchedResults<Item>.Element
    @Environment(\.dismiss) var dismiss //go back
    @State private var name = ""
    @State private var memo = ""
    
    var body: some View {
        
        NavigationView {

                ScrollView {
                    
                    VStack {
                        TextEditor(text : $name)
                            .onAppear {
                                name = memento.name!
                            }
                            .font(.title)
                        
                        HStack {
                            TextEditor( text : $memo)
                                .font(.system(size: 18))
                                .lineSpacing(5)
                                .onAppear{
                                    memo = memento.memo!
                                }
                            //Spacer()
                        }
                    }
                }
                .padding()
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            dismiss()
                        } label: {
                            Text("취소")
                        }
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            DataController().editMemento(memento: memento, name: name, memo: memo, context: managedObjectContext)
                            dismiss()
                        } label: {
                            Text("완료")
                        }

                    }
                }
        }
    }
}


