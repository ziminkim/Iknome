//
//  ComposeView.swift
//  MemoApp
//
//  Created by 김지민 on 2023/07/10.
//

import SwiftUI

struct ComposeView: View {
    @EnvironmentObject var store : MemoStore
    
    var memo: Memo? = nil
    
    @State private var content : String = ""
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView { //네비게이션 뷰로 만들기
            VStack {
                TextEditor(text: $content) //입력을 위해 텍스트에디터
                //content 속성과 텍스트에디터를 바인딩
                    .padding()//기본여백추가
                    .onAppear {
                        if let memo = memo {
                            content = memo.content
                        }
                    }
            }
            .navigationTitle(memo != nil ? "메모 편집" : "새 메모")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading){
                    Button {
                        dismiss()
                    } label: {
                        Text("취소")
                    }

                }
                
                ToolbarItemGroup(placement: .navigationBarTrailing){
                    Button {
                        if let memo = memo{
                            store.update(memo: memo, content: content)
                        } else {
                            store.insert(memo: content)
                        }
                        store.insert(memo: content)
                        dismiss()
                    } label: {
                        Text("저장")
                    }
                }
            }
        }
    }
}

struct ComposeView_Previews: PreviewProvider {
    static var previews: some View {
        ComposeView()
            .environmentObject(MemoStore())//메모스토어를 커스텀 공유로
    }
}
