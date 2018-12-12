//: [Previous](@previous)

struct Crate: Equatable {
	var width, length, height: Float
	var volume: Float {
		return width * length * height
	}
}

Crate(width: 1, length: 2, height: 3) == Crate(width: 1, length: 2, height: 3)
Crate(width: 1, length: 2, height: 3) == Crate(width: 2, length: 2, height: 2)
//: [Next](@next)
