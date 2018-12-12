//: [Previous](@previous)
struct Crate: Equatable {
	var width, length, height: Float
	var volume: Float {
		return width * length * height
	}
}

extension Crate: Hashable {
	func hash(into hasher: inout Hasher) {
		hasher.combine(width)
		hasher.combine(length)
		hasher.combine(height)
	}
}

// should be different
Crate(width: 2, length: 4, height: 3).hashValue
Crate(width: 4, length: 2, height: 3).hashValue
//: [Next](@next)
