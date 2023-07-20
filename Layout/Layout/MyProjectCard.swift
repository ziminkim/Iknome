//
//  MyProjectCard.swift
//  Layout
//
//  Created by 김지민 on 2023/07/20.
//

import SwiftUI

struct MyProjectCard: View {
    var body: some View {
        
        VStack (alignment: .leading) {
            Rectangle().frame(height:0) //화면 가로 가득 채우는 용도
            Text("지민 프로젝트")
                .font(.system(size : 23))//크기
                .fontWeight(.black) //굵게
                .padding(.bottom, 5)
            Text("10am - 11am")
                .foregroundColor(.secondary) //색깔
            Spacer().frame(height: 20)
            
            HStack {
                Circle().frame(width: 50, height: 50)
                Circle().frame(width: 50, height: 50)
                Circle().frame(width: 50, height: 50)
                
                Spacer()
                Text("확인")
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 80)
                    .background(Color.blue)
                    .cornerRadius(20)
                
            }
        }
        .padding(20)
        .background(Color.yellow)
        .cornerRadius(20)
    }
}

struct MyProjectCard_Previews: PreviewProvider {
    static var previews: some View {
        MyProjectCard()
    }
}
