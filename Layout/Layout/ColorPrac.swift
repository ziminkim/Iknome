//
//  ColorPrac.swift
//  Layout
//
//  Created by 김지민 on 2023/08/02.
//

import SwiftUI

struct ColorPrac: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 25)
            .fill(
                //Color(.red)
                //Color(ColorLiteral??)
                Color(uiColor: .systemGray6)
                //Asset > + Set Color > CustomColor
                //Color("CustomColor")
                
            )
            //.shadow(radius: 10, x: , y:, color: )
            .frame(width: 300, height: 200)
    }
}

struct ColorPrac_Previews: PreviewProvider {
    static var previews: some View {
        ColorPrac()
    }
}
