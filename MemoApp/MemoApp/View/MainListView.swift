//
//  MainListView.swift
//  MemoApp
//
//  Created by 김지민 on 2023/07/07.
//

import SwiftUI

struct MainListView: View {
    @EnvironmentObject var store : MemoStore
    
    @State private var showComposer: Bool = false
    var body: some View {
        NavigationView {
            List {
                ForEach(store.list){ memo in
                    NavigationLink{
                        DetailView(memo: memo)
                    } label: {
                        MemoCell(memo: memo)
                    }
                }
                .onDelete(perform: store.delete)
            } .listStyle(.plain)
                .navigationTitle("내 메모")
                .toolbar {
                    Button{
                        showComposer = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                //sheet 모디파이어는 바인딩한 속성이 트루로 바뀌면 실행
                .sheet(isPresented: $showComposer) {
                    ComposeView()
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct MainListView_Previews: PreviewProvider {
    static var previews: some View {
        MainListView()
            .environmentObject(MemoStore())
    }
}

