//
//  ContentView.swift
//  Layout
//
//  Created by 김지민 on 2023/07/20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        ZStack (alignment: .bottomTrailing) {
            
            VStack (alignment: .leading, spacing: 10) {
                
                HStack {
                    Image(systemName: "line.horizontal.3")
                        .font(.largeTitle)
                    Spacer()
                    Image(systemName: "person.crop.circle.fill")
                        .font(.largeTitle)
                }
                
                Text("지민 할일 목록")
                    .font(.system(size: 40))
                    .fontWeight(.black)
                
                ScrollView {
                    VStack {
                        MyProjectCard()
                        MyBasicCard()
                        MyBasicCard()
                        MyBasicCard()
                        MyBasicCard()
                        MyBasicCard()
                    }
                }
            }
            .padding(.top, 20)
            .padding(.horizontal, 20)
            
            Circle()
                .foregroundColor(.yellow)
                .frame(width: 60, height: 60)
                .padding(.trailing, 10)
                .shadow(radius: 10)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
