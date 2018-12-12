//
//  2-Swap Refactoring.playground
//  Packt Progressional Swift Courseware
//
//  Created by robkerr@mobiletoolworks.com on 11/19/2018.
//
import UIKit

func swapValues<T>(_ a: inout T, _ b: inout T) {
    let temp = a
    a = b
    b = temp
}

var d = Dictionary<Int, String>()
var a = Array<Int>()


var dt1 = Date.distantFuture
var dt2 = Date.distantPast
swapValues(&dt1, &dt2)
print(dt1, dt2)

var anInt:Int = 4
var anotherInt:Int = 5

// initial values
print(anInt, anotherInt)
swapValues(&anInt, &anotherInt)

// final values
print(anInt, anotherInt)

var aDouble = 4.73
var anotherDouble = 5.5

// initial values
print(aDouble, anotherDouble)
swapValues(&anInt, &anotherInt)

// final values
print(aDouble, anotherDouble)

var aString = "Hello"
var anotherString = "World"

// initial values
print(aString, anotherString)
swapValues(&aString, &anotherString)

// final values
print(aString, anotherString)

