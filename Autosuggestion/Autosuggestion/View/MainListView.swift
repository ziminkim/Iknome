//
//  ListView.swift
//  Autosuggestion
//
//  Created by 김지민 on 2023/07/14.
//

import SwiftUI

struct MainListView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var memento : FetchedResults<Item>
    
    @State var movetocreate : Bool = false
    
    
    
    var body: some View {
        
        NavigationView{
            
                List {
                    //여기 메모 & 녹음 파일을 가진 폴더 리스트를 넣을거야
                    //객체 간에 관계가 있게 저장? sqlite나 coredata 사용해서 만들기
                    ForEach (memento) { memento in
                        NavigationLink(destination: StreamingView(memento: memento)) { //
                            
                            VStack(alignment: .leading) {
                                //제목
                                Text(memento.name!)
                                //시간
                                HStack {
                                    Text("알람 주기랑 녹음길이")
                                }
                            }
                            
                        }
                    }
                    .onDelete(perform: deleteMemento)
                    
                }
                .listStyle(.plain)
                .navigationTitle("Memento List")
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarLeading) {
                        EditButton()
                    }
                    
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        Button {
                            self.movetocreate = true
                            
                        } label: {
                            Image(systemName: "plus")
                        }
                    .fullScreenCover(isPresented: $movetocreate){
                        CreateView()
                    }
                }
            }
        }
    }
    
    func deleteMemento(offset: IndexSet) {
        withAnimation {
            offset.map { memento[$0] }.forEach(managedObjectContext.delete)
            
            DataController().save(context: managedObjectContext)
        }
        
    }
    
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        MainListView()
    }
}
