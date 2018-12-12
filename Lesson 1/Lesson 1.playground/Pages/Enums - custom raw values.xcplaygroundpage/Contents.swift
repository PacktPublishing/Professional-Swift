//: [Previous](@previous)

enum TestResult: RawRepresentable {
	typealias RawValue = (reality: Bool, test: Bool)

	case falsePositive, falseNegative, truePositive, trueNegative

	init?(rawValue: RawValue) {
		switch rawValue {
		case (true,true):
			self = .truePositive
		case (false,true):
			self = .falsePositive
		case (true,false):
			self = .falseNegative
		case (false,false):
			self = .trueNegative
		}
	}

	var rawValue: RawValue {
		switch self {
		case .truePositive:
			return (true,true)
		case .falsePositive:
			return (false,true)
		case .falseNegative:
			return (true,false)
		case .trueNegative:
			return (false,false)
		}
	}
}

let t1 = TestResult(rawValue: (reality: false, test: true))
t1?.rawValue
let t2 = TestResult(rawValue: (reality: true, test: false))
t1 == t2
t1?.hashValue
t2?.hashValue
//: [Next](@next)
