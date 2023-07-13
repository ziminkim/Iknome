//
//  Memo.swift
//  MemoApp
//
//  Created by 김지민 on 2023/07/07.
//

import Foundation
import SwiftUI

//protocal 데이터를 리스트에 바인딩, 뷰 자동 업데이트
class Memo : Identifiable, ObservableObject {
    let id : UUID
    @Published var content : String
    let insertDate : Date
    
    init(content : String, insertDate : Date = Date.now){
        id = UUID()
        self.content = content
        self.insertDate = insertDate
    }
}
