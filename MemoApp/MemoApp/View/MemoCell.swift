//
//  MemoCell.swift
//  MemoApp
//
//  Created by 김지민 on 2023/07/10.
//

import SwiftUI

//뷰 분리해서 코드 단순하게 만들기!
struct MemoCell: View {
    @ObservedObject var memo : Memo
    //메모 업데이트 될때마다 업데이트
    var body: some View {
        VStack(alignment: .leading) { //왼쪽 정렬
            Text(memo.content)
                .font(.body)
                .lineLimit(1) //한줄처리 뒷부분은 ...
            Text(memo.insertDate, style: .date)
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }
}


struct MemoCell_Previews: PreviewProvider {
    static var previews: some View {
        MemoCell(memo: Memo(content : "Test"))
    }
}
