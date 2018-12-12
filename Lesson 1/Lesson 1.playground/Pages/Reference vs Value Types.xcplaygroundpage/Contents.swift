
import Foundation

let value: Array = [1,2] // a struct
var copyOfValue = value
copyOfValue.removeFirst()

value        // [1,2]
copyOfValue  // [2]

let reference: NSMutableArray = [1,2] // a class
let reference2 = reference
reference2.removeObject(at: 0)

reference    // [2]
reference2   // [2]

//: [Next](@next)
