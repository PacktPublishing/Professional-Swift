//
//  1-Swap Introduction.playground
//  Packt Progressional Swift Courseware
//
//  Created by robkerr@mobiletoolworks.com on 11/19/2018.
//
import UIKit

func swapValues(_ a: inout Int, _ b: inout Int) {
    let temp = a
    a = b
    b = temp
}

func swapValues(_ a: inout Double, _ b: inout Double) {
    let temp = a
    a = b
    b = temp
}

func swapValues(_ a: inout String, _ b: inout String) {
    let temp = a
    a = b
    b = temp
}

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

