//
//  DetailView.swift
//  MemoApp
//
//  Created by 김지민 on 2023/07/10.
//

import SwiftUI

struct DetailView: View {
    @ObservedObject var memo : Memo
    @EnvironmentObject var store : MemoStore
    @State private var showCoposer = false
    @State private var showDeleteAlert = false
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack{
            ScrollView{
                VStack{
                    HStack {
                        Text(memo.content)
                            .padding()
                        Spacer(minLength: 0)
                    }
                    
                    Text(memo.insertDate, style: .date)
                        .padding()
                        .font(.footnote)
                        .foregroundColor(.secondary)
                    
                }
            }
        }
        .navigationTitle("메모 보기")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            ToolbarItemGroup(placement: .bottomBar) {
                Button {
                    showDeleteAlert = true
                } label: {
                    Image(systemName: "trash")
                }
                .foregroundColor(.red)
                .alert("삭제 확인", isPresented: $showDeleteAlert) {
                    Button(role: .destructive) { //적절한 위치와 빨간색 자동
                        store.delete(memo: memo)
                        dismiss()
                    } label: {
                        Text("삭제")
                    }
                } message: {
                    Text("메모를 삭제할까요?")
                }

                Button {
                    showCoposer = true
                } label: {
                    Image(systemName: "square.and.pencil")
                }
            }
        }
        .sheet(isPresented: $showCoposer) {
            ComposeView(memo: memo)
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailView(memo: Memo(content: "hello"))
                .environmentObject(MemoStore())
        }
    }
}
