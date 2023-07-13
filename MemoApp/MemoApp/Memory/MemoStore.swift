//
//  MemoStore.swift
//  MemoApp
//
//  Created by 김지민 on 2023/07/07.
//

import Foundation
//메모 목록 저장하는 클래스
class MemoStore: ObservableObject {
    //배열 Published로 하면 배열을 업데이트 할 때마다 바인딩 되어있는 뷰도 자동으로 업데이트
    @Published var list: [Memo]
    
    init(){
        list = [
            Memo(content : "Hello", insertDate: Date.now),
            Memo(content : "Awesome", insertDate: Date.now.addingTimeInterval(3600 * -24)),
            Memo(content : "SwiftUI", insertDate: Date.now.addingTimeInterval(3600 * -48)),
        ]
    }
    
    func insert(memo : String) {
        list.insert(Memo(content : memo), at: 0)//0번 인덱스에 새로운 메모 저장
    }
        
    func update(memo : Memo?, content : String){
        guard let memo = memo else {
            return
        }
        memo.content = content
    }
    
    func delete(memo : Memo) {
        list.removeAll { $0.id == memo.id}
    }
    
    func delete(set : IndexSet) {
        for index in set {
            list.remove(at: index)
        }
    }
}
