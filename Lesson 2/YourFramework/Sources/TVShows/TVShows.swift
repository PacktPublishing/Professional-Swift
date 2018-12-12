struct TVShows {
    var text = "Hello, World!"
}






extension KeyedDecodingContainer {
	private func decodeNested<T:Decodable>(_ type: T.Type, forKeyPath keys: [Key]) throws -> T {
		var keys = keys
		let key = keys.removeFirst()
		if keys.isEmpty {
			return try self.decode(type, forKey: key)
		}
		let container = try nestedContainer(keyedBy: Key.self, forKey: key)
		return try container.decodeNested(type, forKeyPath: keys)
	}

	func decodeNested<T:Decodable>(_ type: T.Type, forKeyPath firstkey: Key, _ nextkeys: Key...) throws -> T {
		return try decodeNested(type, forKeyPath: [firstkey] + nextkeys)
	}

	private func decodeNestedIfPresent<T:Decodable>(_ type: T.Type, forKeyPath keys: [Key]) throws -> T? {
		var keys = keys
		let key = keys.removeFirst()
		if keys.isEmpty {
			return try self.decodeIfPresent(type, forKey: key)
		}
		guard self.contains(key), !(try self.decodeNil(forKey: key)) else { return nil }
		let container = try nestedContainer(keyedBy: Key.self, forKey: key)
		return try container.decodeNestedIfPresent(type, forKeyPath: keys)
	}

	func decodeNestedIfPresent<T:Decodable>(_ type: T.Type, forKeyPath firstkey: Key, _ nextkeys: Key...) throws -> T? {
		return try decodeNestedIfPresent(type, forKeyPath: [firstkey] + nextkeys)
	}
}

extension KeyedEncodingContainer {
	mutating private func encodeNested<T:Encodable>(_ thing: T, forKeyPath keys: [Key]) throws {
		var keys = keys
		let key = keys.removeFirst()
		if keys.isEmpty {
			return try self.encode(thing, forKey: key)
		}
		var container = self.nestedContainer(keyedBy: Key.self, forKey: key)
		try container.encodeNested(thing, forKeyPath: keys)
	}

	mutating func encodeNested<T:Encodable>(_ thing: T, forKeyPath firstkey: Key, _ nextkeys: Key...) throws {
		try encodeNested(thing, forKeyPath: [firstkey] + nextkeys)
	}
}
