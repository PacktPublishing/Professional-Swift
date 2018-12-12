
import Foundation

enum DayOfWeek: String, Decodable {
	case Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday
}

struct ScheduleTime {
	let time: (hours: Int, minutes: Int)?
	let dayOfWeek: DayOfWeek
}

extension ScheduleTime {
	init?(time: String, dayOfWeek: String) {
		guard let dayOfWeek = DayOfWeek(rawValue: dayOfWeek) else { return nil }
		guard !time.isEmpty else {
			self = ScheduleTime(time: nil, dayOfWeek: dayOfWeek)
			return
		}
		let components = time.split(separator: ":")
		guard components.count == 2,
			let hours = Int(components[0]),
			let minutes = Int(components[1])
			else { return nil }
		self = ScheduleTime(time: (hours,minutes), dayOfWeek: dayOfWeek)
	}

	private struct TVMazeSchedule: Codable {
		let time: String
		let days: [String]
	}

	fileprivate static func schedules(from container: KeyedDecodingContainer<Show.CodingKeys>, forKey key: Show.CodingKeys) throws -> [ScheduleTime] {
		let mazeschedule = try container.decode(TVMazeSchedule.self, forKey: key)
		return try mazeschedule.days.map { day in
			guard let schedule = ScheduleTime(time: mazeschedule.time, dayOfWeek: day) else {
				throw DecodingError.dataCorruptedError(
					forKey: key, in: container,
					debugDescription: "'\(day) \(mazeschedule.time)' is not a valid schedule.")
			}
			return schedule
		}
	}

	fileprivate static func encode(_ schedules: [ScheduleTime], to container: inout KeyedEncodingContainer<Show.CodingKeys>, forKey key: Show.CodingKeys) throws {
		guard let time = schedules.first.map({ schedule in schedule.time.map {"\($0):\($1)"} ?? "" }) else { return }
		let mazeschedule = TVMazeSchedule(time: time, days: schedules.map { $0.dayOfWeek.rawValue })
		try container.encode(mazeschedule, forKey: key)
	}
}

fileprivate struct ImageURLs: Codable {
	let medium: URL
	let original: URL
}

struct Person: Codable {
	let id: Int
	let name: String
	let summary: String?
	let countryofbirth: String?
}

struct Character {
	let id: Int
	let name: String
	let summary: String?
	let image: URL?
	let actor: Person
}

extension Character: Codable {
	fileprivate enum CodingKeys: String, CodingKey {
		case person, character
	}
	fileprivate struct CharacterDecoder: Codable {
		let id: Int
		let name: String
		let image: ImageURLs?
		let summary: String?
	}

	init(from decoder: Decoder) throws {
		let actorandcharacter = try decoder.container(keyedBy: CodingKeys.self)
		actor = try actorandcharacter.decode(Person.self, forKey: .person)
		let character = try actorandcharacter.decode(CharacterDecoder.self, forKey: .character)
		id = character.id
		name = character.name
		image = character.image?.original
		summary = character.summary
	}

	func encode(to encoder: Encoder) throws {
		var actorandcharacter = encoder.container(keyedBy: CodingKeys.self)
		try actorandcharacter.encode(actor, forKey: .person)
		let imageurls = image.map { ImageURLs(medium: $0, original: $0) }
		try actorandcharacter.encode(CharacterDecoder(id: id, name: name, image: imageurls, summary: summary),
		                             forKey: .character)
	}
}

struct Episode: Codable {
	let id: Int
	let name: String
	let summary: String?
	let season: Int
	let episodeNumber: Int? // Specials do not have episode number
	let firstAiredAt: Date?

	private enum CodingKeys: String, CodingKey {
		case id
		case name
		case summary
		case season
		case episodeNumber = "number"
		case firstAiredAt = "airstamp"
	}
}

struct Show {
	enum Status: String, Codable {
		case Running, Ended, ToBeDetermined  = "To Be Determined", InDevelopment = "In Development"
	}

	let id: Int
	let name: String
	let summary: String?
	let image: URL?
	let status: Status
	let showtype: String
	let length: Int?
	let schedule: [ScheduleTime]
	let genres: [String]
	let officialSite: URL?
	let airsOn: String?
	let voteaverage: Double?
	let crew: [(person: Person, role: String)]
	let characters: [Character]
	let episodes: [Episode]
}

extension Show: Codable {
	fileprivate enum CodingKeys: String, CodingKey {
		case id, name, summary, image, status, showtype = "type", length = "runtime", schedule, genres, officialSite, airsOn = "network", voteaverage1 = "rating", voteaverage2 = "average", embedded = "_embedded", crew, characters = "cast", episodes
	}

	private struct Crew: Codable { let type: String; let person: Person }

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		id = try container.decode(Int.self, forKey: .id)
		name = try container.decode(String.self, forKey: .name)
		summary = try container.decodeIfPresent(String.self, forKey: .summary)
		image = try container.decodeIfPresent(ImageURLs.self, forKey: .image)?.original
		status = try container.decode(Status.self, forKey: .status)
		showtype = try container.decode(String.self, forKey: .showtype)
		length = try container.decodeIfPresent(Int.self, forKey: .length)
		officialSite = try container.decodeIfPresent(URL.self, forKey: .officialSite)

		schedule = try ScheduleTime.schedules(from: container, forKey: .schedule)
		
		genres = try container.decodeIfPresent([String].self, forKey: .genres) ?? []
		airsOn = try container.decodeNestedIfPresent(String.self, forKeyPath: .airsOn, .name)
		voteaverage = try container.decodeNested(Double?.self, forKeyPath: .voteaverage1, .voteaverage2)

		let embeddedContainer = container.contains(.embedded)
			? try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .embedded)
			: nil

		crew = try embeddedContainer?.decodeIfPresent([Crew].self, forKey: .crew)?
			.map { crew in (crew.person, crew.type) } ?? []

		characters = try embeddedContainer?.decodeIfPresent([Character].self, forKey: .characters) ?? []
		episodes = try embeddedContainer?.decodeIfPresent([Episode].self, forKey: .episodes) ?? []
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(id, forKey: .id)
		try container.encode(name, forKey: .name)
		try container.encode(summary, forKey: .summary)
		try container.encode(image.map { ImageURLs(medium: $0, original: $0) }, forKey: .image)
		try container.encode(status, forKey: .status)
		try container.encode(showtype, forKey: .showtype)
		try container.encode(length, forKey: .length)
		try container.encode(officialSite, forKey: .officialSite)

		try ScheduleTime.encode(schedule, to: &container, forKey: .schedule)

		try container.encode(genres, forKey: .genres)
		try container.encodeNested(airsOn, forKeyPath: .airsOn, .name)
		try container.encodeNested(voteaverage, forKeyPath: .voteaverage1, .voteaverage2)

		var embeddedContainer = container.nestedContainer(keyedBy: CodingKeys.self, forKey: .embedded)

		let crewarray = crew.map { Crew(type: $0.role, person: $0.person) }
		try embeddedContainer.encode(crewarray, forKey: .crew)

		try embeddedContainer.encode(characters, forKey: .characters)
		try embeddedContainer.encode(episodes, forKey: .episodes)
	}
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
