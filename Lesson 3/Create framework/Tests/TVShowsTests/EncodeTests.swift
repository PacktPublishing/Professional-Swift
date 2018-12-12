import XCTest
import Foundation
@testable import TVShows

let testurl = URL(string: "http://web.net/test.url")
let person = Person(id: 2, name: "Some Actor", summary: "completely unknown", countryofbirth: nil)
let episode = Episode(id: 3, name: "The one with", summary: "something funny", season: 7, episodeNumber: 21, firstAiredAt: Date.distantPast)
let character = TVShows.Character(id: 4, name: "Waiter nr. 5", summary: "Unimportant", image: testurl, actor: person)
let show = Show(id: 5, name: "The Show", summary: "showy", image: testurl, status: .Ended, showtype: "Meta", length: 44, schedule: [ScheduleTime(time:(hours: 5, minutes: 20), dayOfWeek: .Sunday)], genres: ["Action", "Drama"], officialSite: testurl, airsOn: "CDD", voteaverage: 3.4, crew: [(person, "Creator")], characters: [character], episodes: [episode])

class EncodeTests: XCTestCase {
	func testPerson() {
		do {
			let encoder = PropertyListEncoder()
			let data = try encoder.encode(person)

			let decoder = PropertyListDecoder()
			let decodedperson = try decoder.decode(Person.self, from: data)

			XCTAssertEqual(person, decodedperson)
		} catch {
			XCTFail(String(describing: error))
		}
	}

	func testEpisode() {
		do {
			let encoder = JSONEncoder()
			let data = try encoder.encode(episode)

			let decoder = JSONDecoder()
			let decodedepisode = try decoder.decode(Episode.self, from: data)

			XCTAssertEqual(episode, decodedepisode)
		} catch {
			XCTFail(String(describing: error))
		}
	}

	func testCharacter() {
		do {
			let encoder = JSONEncoder()
			let data = try encoder.encode(character)

			let decoder = JSONDecoder()
			let decodedcharacter = try decoder.decode(Character.self, from: data)

			XCTAssertEqual(character, decodedcharacter)
		} catch {
			XCTFail(String(describing: error))
		}
	}

	func testShow() {
		do {
			let encoder = JSONEncoder()
			let data = try encoder.encode(show)

			let decoder = JSONDecoder()
			let decodedshow = try decoder.decode(Show.self, from: data)

			XCTAssertEqual(show, decodedshow)
		} catch {
			XCTFail(String(describing: error))
		}
	}
}
