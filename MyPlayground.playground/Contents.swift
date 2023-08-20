import Swift

// create some enumerations
enum Colors:Int, CaseIterable {
    case RED
    case GREEN
    case BLUE
}

enum Fruits:String, CaseIterable {
    case MANGO, PINEAPPLE, ORANGE
}

enum Seasons:String, CaseIterable {
    case WINTER, SPRING, AUTUMN, SUMMER
}

print(Colors.allCases)
print(Fruits.allCases)
print(Seasons.allCases)
