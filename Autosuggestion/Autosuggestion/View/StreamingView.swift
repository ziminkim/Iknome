//
//  StreamingView.swift
//  Autosuggestion
//
//  Created by 김지민 on 2023/07/11.
//

import SwiftUI
import CoreData

struct StreamingView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    var memento: FetchedResults<Item>.Element
    @Environment(\.dismiss) var dismiss //go back
    
    @State var movetoedit = false
    @State var movetoalarm = false

    var body: some View {
        //오토레이아웃 배우고 다시 올게
        VStack {
            ScrollView {
                HStack {
                    Text(memento.memo!)
                        .font(.system(size: 18))
                        .lineSpacing(5)
                    Spacer()
                }
            }
        
        }
        .navigationTitle(memento.name!)
        .padding(20)
        .sheet(isPresented: $movetoedit){
            EditView(memento: memento)
        }
        .sheet(isPresented: $movetoalarm){
            AlarmView(memento: memento)
        }
        .toolbar {
            ToolbarItem(placement:.navigationBarTrailing){
                Button {
                    movetoalarm.toggle()
                    
                } label: {
                    Image(systemName: "clock")
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {

                Button {
                    movetoedit.toggle()
                } label: {
                    Image(systemName: "square.and.pencil")
                }

            }
        }
            
    }
}


