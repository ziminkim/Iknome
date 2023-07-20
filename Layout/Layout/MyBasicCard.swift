//
//  MyProjectCard.swift
//  Layout
//
//  Created by 김지민 on 2023/07/20.
//

import SwiftUI

struct MyBasicCard: View {
    var body: some View {
        
        HStack (spacing: 20) {
            
            Circle().frame(width: 50, height: 50)
            
            VStack(alignment: .leading, spacing: 0){
                Divider().opacity(0)
                Rectangle().frame(height:0)
                Text("하하")
                    .fontWeight(.bold)
                    .font(.system(size: 23))
                    .foregroundColor(.white)
                Spacer().frame(height: 5)
                Text("하하")
                    .foregroundColor(.white)
                
            }
        }
        .padding(20)
        .background(Color.blue)
        .cornerRadius(20)
    }
}

struct MyBasicCard_Previews: PreviewProvider {
    static var previews: some View {
        MyBasicCard()
    }
}
