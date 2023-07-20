//
//  ContentView.swift
//  icalories
//
//  Created by 김지민 on 2023/07/14.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var food : FetchedResults<Food>
    
    @State private var showingAddView = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("\(Int(totalCaloriesToday())) Kcal (Today)")
                    .foregroundColor(.gray)
                    .padding(.horizontal)
                
                List {
                    ForEach (food) { food in//uuid
                        NavigationLink(destination: EditFoodView(food: food)) {
                            HStack {
                                VStack(alignment: .leading, spacing: 6) {
                                    Text(food.name!)
                                        .bold()
                                    Text("\(Int(food.calories))") + Text(" calories").foregroundColor(.red)
                                }
                                Spacer()
                                Text(calcTimeSince(date:food.date!))
                                    .foregroundColor(.gray)
                                    .italic()
                            }
                        }
                        
                    }
                    .onDelete(perform: deleteFood)
                }
                .listStyle(.plain)
            }
            .navigationTitle("iCalories")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddView.toggle()
                    } label: {
                        Label("Add Food", systemImage: "plus.circle")
                    }
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
            }
            .sheet(isPresented: $showingAddView) {
                AddFoodView()
            }
        }
        .navigationViewStyle(.stack)
    }
    
    private func deleteFood(offset: IndexSet) {
        withAnimation {
            offset.map { food[$0] }.forEach(managedObjectContext.delete)
            
            DataController().save(context: managedObjectContext)
        }
        
    }
    
    private func totalCaloriesToday() -> Double{
        var caloriesToday : Double = 0
        for item in food {
            if Calendar.current.isDateInToday(item.date!) {
                caloriesToday += item.calories
            }
        }
        return caloriesToday
    }
}
    

    

    
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
