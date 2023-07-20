//
//  AddFoodView.swift
//  icalories
//
//  Created by 김지민 on 2023/07/17.
//

import SwiftUI

struct AddFoodView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.dismiss) var dismiss //go back
    
    @State private var name = ""
    @State private var calories : Double = 0
    
    var body: some View {
        Form {
            Section{
                TextField("Food name", text: $name)
                
                VStack {
                    Text("Calories : \(Int(calories))")
                    Slider(value: $calories, in: 0...1000, step: 10)
                }
                .padding()
                
                HStack {
                    Spacer()
                    Button("Submit") {
                        DataController().addFood(name: name, calories: calories, context: managedObjectContext)
                        dismiss()
                    }
                    Spacer()
                    
                }
            }
        }
    }
}

struct AddFoodView_Previews: PreviewProvider {
    static var previews: some View {
        AddFoodView()
    }
}
