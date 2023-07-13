//
//  MemoAppApp.swift
//  MemoApp
//
//  Created by 김지민 on 2023/07/07.
//

//메모 저장소를 모든 뷰에서 사용할 수 있도록, 커스텀 공유 데이터로 등록
import SwiftUI

@main
struct MemoAppApp: App { //public protocol
    //메모 저장소를 속성으로 저장
    @StateObject var store = MemoStore() //앞서만든 메모스토어 클래스
    var body: some Scene {
        WindowGroup {
            MainListView()
                //메인리스트 뷰와 이어지는 뷰에서 동일한 객체를 쉽게 사용 가능
                .environmentObject(store)
        }
    }
}
