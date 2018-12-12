//: [Previous](@previous)

enum List<Element> {
	case end
	indirect case node(value: Element, next: List<Element>)
}

