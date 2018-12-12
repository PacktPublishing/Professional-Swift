//: [Previous](@previous)
struct Crate: Equatable {
	var width, length, height: Float
	var volume: Float {
		return width * length * height
	}
}

extension Crate: Comparable {
	static func <(lhs: Crate, rhs: Crate) -> Bool {
		return lhs.volume < rhs.volume
	}
}

let a = Crate(width: 2, length: 3, height: 1)
let b = Crate(width: 3, length: 2, height: 1)
let c = Crate(width: 3, length: 2, height: 2)

// only 1 of these should be true
a==b
a<b
b<a

// all of these should be true
!(a < a)
a < b ? !(b < a) : true
(a < b && b < c) ? a < c : true

//: [Next](@next)
