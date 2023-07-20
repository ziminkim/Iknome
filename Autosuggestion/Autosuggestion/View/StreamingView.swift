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
    var auto: FetchedResults<Item>.Element
    @Environment(\.dismiss) var dismiss //go back
    
    @State var movetoedit = false

    var body: some View {
        //오토레이아웃 배우고 다시 올게
        VStack { 
            Text(auto.name!)
                .frame(alignment: .leading)
                .background(Color.red)
                .font(.title)
            ScrollView {
                Text(auto.memo!)
                    .frame(alignment: .leading)
                    .background(Color.orange)
                    .padding()
                    
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    movetoedit.toggle()
                } label: {
                    Image(systemName: "pencil.circle")
                }

            }
        }
    }
}


