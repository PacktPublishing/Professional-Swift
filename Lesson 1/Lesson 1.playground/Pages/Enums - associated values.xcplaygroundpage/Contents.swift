//: [Previous](@previous)

enum CaretPosition {
    case none
    case position(Int)
    case selection(from: Int, to: Int)
    case multipleSelections([(from: Int, to: Int)])
}

extension CaretPosition {
    func contains(position: Int) -> Bool {
        switch self {
        case .selection(let selection):
            return (selection.from...selection.to).contains(position)
        case .multipleSelections(let selections):
            return selections.contains(where: { from, to in
                (from...to).contains(position) })
        default:
            return false
        }
    }
}

CaretPosition.none.contains(position: 1)
CaretPosition.selection(from: 5, to: 9).contains(position: 5)
CaretPosition.multipleSelections([(2,5),(8,20)]).contains(position: 2)

let s = CaretPosition.selection(from: 1, to: 5)

if case let CaretPosition.selection(from, to) = s {
    print(from,to)
}

//: [Next](@next)
