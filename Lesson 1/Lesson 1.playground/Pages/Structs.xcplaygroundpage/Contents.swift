//: [Previous](@previous)

struct GroceryProduct {
	let name: String
	var price: Float
	var quantity: Int

	var totalValue: Float {
		return price * Float(quantity)
	}
	mutating func sell(_ count: Int) {
		quantity -= count
	}
}

var product = GroceryProduct(name: "Apple", price: 0.99, quantity: 100)
product.sell(5)


struct ConstantGroceryProduct {
	let name: String
	let price: Float
	let quantity: Int

	var totalValue: Float {
		return price * Float(quantity)
	}
	func selling(_ count: Int) -> ConstantGroceryProduct {
		return ConstantGroceryProduct(name: name, price: price, quantity: quantity-count)
	}
}

let constantproduct = ConstantGroceryProduct(name: "Apple", price: 0.99, quantity: 100)
constantproduct.selling(5)

extension GroceryProduct: Equatable {
	static func ==(lhs: GroceryProduct, rhs: GroceryProduct) -> Bool {
		return lhs.name == rhs.name
	}
}
//: [Next](@next)
