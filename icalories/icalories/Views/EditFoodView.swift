//
//  EditFoodView.swift
//  icalories
//
//  Created by 김지민 on 2023/07/17.
//

import SwiftUI

struct EditFoodView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.dismiss) var dismiss //go back
    
    var food: FetchedResults<Food>.Element
    
    @State private var name = ""
    @State private var calories: Double = 0
    
    var body: some View {
        Form {
            Section {
                TextField("\(food.name!)", text : $name) //TextField는 입력을 받아옵니다
                    .onAppear {
                        name = food.name!
                        calories = food.calories
                    }
                VStack {
                    Text("Calories : \(Int(calories))")
                    Slider(value: $calories, in: 0...1000, step: 10)
                }
                .padding()
                
                HStack {
                    Spacer()
                    Button("Submit") {
                        DataController().editFood(food: food, name: name, calories: calories, context: managedObjectContext)
                        dismiss()
                    }
                    Spacer()
                }
            }
        }
    }
}

