//: [Previous](@previous)

enum ProgrammingLanguage: String {
    case C, CPlusPlus = "C++", ObjectiveC = "Objective-C", Swift
}

let l = ProgrammingLanguage(rawValue: "C++") // type is ProgrammingLanguage?, value is CPlusPlus
ProgrammingLanguage.C.rawValue // "C"

//: [Next](@next)
