//: [Previous](@previous)

struct CopyOnWriteType {
	private class Reference {
		var prop1: Int
		var prop2: Double

		init (prop1: Int, prop2: Double) {
			self.prop1 = prop1
			self.prop2 = prop2
		}

		func copy() -> Reference {
			return Reference(prop1: prop1, prop2: prop2)
		}
	}

	private var reference: Reference

	init (prop1: Int, prop2: Double) {
		reference = Reference(prop1: prop1, prop2: prop2)
	}

	private mutating func ensureUnique() {
		if !isKnownUniquelyReferenced(&reference) {
			reference = reference.copy()
		}
	}

	var prop1: Int {
		get { return reference.prop1 }
		set {
			ensureUnique()
			reference.prop1 = newValue
		}
	}

	var prop2: Double {
		get { return reference.prop2 }
		set {
			ensureUnique()
			reference.prop2 = newValue
		}
	}

	mutating func doSomethingMutating() {
		ensureUnique()
		// something mutating
	}
}

var a = CopyOnWriteType(prop1: 1, prop2: 2)
var b = a

a.prop1 = 10
b.prop1 // still 1

a.prop1

//: [Next](@next)
