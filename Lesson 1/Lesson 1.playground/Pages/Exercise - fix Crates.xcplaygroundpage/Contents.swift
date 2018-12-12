//: [Previous](@previous)

struct Crate {
	let id: Int
	let width, length, height: Float
	var volume: Float {
		return width * length * height
	}
}

let a = Crate(id: 100, height: 1, side1: 2, side2: 3)
let b = Crate(id: 101, height: 1, side1: 3, side2: 2)
let c = Crate(id: 102, height: 2, side1: 3, side2: 2)

// only 1 of these should be true
a==b
a<b
b<a

// all of these should be true
!(a < a)
a < b ? !(b < a) : true
(a < b && b < c) ? a < c : true
//: [Next](@next)
