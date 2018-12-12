import XCTest
@testable import TVShows

class TVShowsDecodeTests: XCTestCase {
	func testPerson() {
		let json = """
			{
			"id": 1,
			"url": "http://www.tvmaze.com/people/1/mike-vogel",
			"name": "Mike Vogel",
			"image": {
				"medium": "http://static.tvmaze.com/uploads/images/medium_portrait/0/1815.jpg",
				"original": "http://static.tvmaze.com/uploads/images/original_untouched/0/1815.jpg"
				},
			"_links": {
				"self": {
					"href": "http://api.tvmaze.com/people/1"
					}
				}
			}
			""".data(using: .utf8)!
		do {
			let decoder = JSONDecoder()
			let person = try decoder.decode(Person.self, from: json)

			XCTAssertEqual(person.name, "Mike Vogel")
			XCTAssertEqual(person.id, 1)
		} catch {
			XCTFail(String(describing: error))
		}
	}

	func testEpisode() {
		let json = """
			{
			"id": 1,
			"url": "http://www.tvmaze.com/episodes/1/under-the-dome-1x01-pilot",
			"name": "Pilot",
			"season": 1,
			"number": 1,
			"airdate": "2013-06-24",
			"airtime": "22:00",
			"airstamp": "2013-06-25T02:00:00+00:00",
			"runtime": 60,
			"image": {
				"medium": "http://static.tvmaze.com/uploads/images/medium_landscape/1/4388.jpg",
				"original": "http://static.tvmaze.com/uploads/images/original_untouched/1/4388.jpg"
				},
			"summary": "<p>When the residents of Chester's Mill find themselves trapped under a massive transparent dome with no way out, they struggle to survive as resources rapidly dwindle and panic quickly escalates.</p>",
			"_links": {
				"self": {
					"href": "http://api.tvmaze.com/episodes/1"
					}
				}
			}
			""".data(using: .utf8)!
		do {
			let decoder = JSONDecoder()
			decoder.dateDecodingStrategy = .iso8601
			let episode = try decoder.decode(Episode.self, from: json)

			XCTAssertEqual(episode.name, "Pilot")
			XCTAssertEqual(episode.id, 1)
			XCTAssertEqual(episode.season, 1)
			XCTAssertEqual(episode.episodeNumber, 1)
			XCTAssertEqual(episode.firstAiredAt, ISO8601DateFormatter().date(from: "2013-06-25T02:00:00+00:00"))
			XCTAssertEqual(episode.summary?.hasPrefix("<p>When the"), true)
		} catch {
			XCTFail(String(describing: error))
		}
	}

	func testCharacter() {
		let json = """
			{
				"person": {
					"id": 7,
					"url": "http://www.tvmaze.com/people/7/mackenzie-lintz",
					"name": "Mackenzie Lintz",
					"image": {
						"medium": "http://static.tvmaze.com/uploads/images/medium_portrait/3/7816.jpg",
						"original": "http://static.tvmaze.com/uploads/images/original_untouched/3/7816.jpg"
					},
					"_links": {
						"self": {
							"href": "http://api.tvmaze.com/people/7"
						}
					}
				},
				"character": {
					"id": 7,
					"url": "http://www.tvmaze.com/characters/7/under-the-dome-norrie-calvert-hill",
					"name": "Norrie Calvert-Hill",
					"image": {
						"medium": "http://static.tvmaze.com/uploads/images/medium_portrait/0/793.jpg",
						"original": "http://static.tvmaze.com/uploads/images/original_untouched/0/793.jpg"
					},
					"_links": {
						"self": {
							"href": "http://api.tvmaze.com/characters/7"
						}
					}
				}
			}
			""".data(using: .utf8)!
		do {
			let decoder = JSONDecoder()
			let character = try decoder.decode(Character.self, from: json)

			XCTAssertEqual(character.id, 7)
			XCTAssertEqual(character.name, "Norrie Calvert-Hill")
			XCTAssertEqual(character.image, URL(string: "http://static.tvmaze.com/uploads/images/original_untouched/0/793.jpg"))
			XCTAssertEqual(character.actor.id, 7)
			XCTAssertEqual(character.actor.name, "Mackenzie Lintz")
		} catch {
			XCTFail(String(describing: error))
		}
	}

	func testShow() {
		do {
			// from http://api.tvmaze.com/shows/1?embed[]=episodes&embed[]=cast&embed[]=crew
			let json = try Data(contentsOf: resource(atPath: "tvshow.json"))
			let decoder = JSONDecoder()
			decoder.dateDecodingStrategy = .iso8601
			let show = try decoder.decode(Show.self, from: json)

			XCTAssertEqual(show.id, 1)
			XCTAssertEqual(show.name, "Under the Dome")
			XCTAssertEqual(show.image, URL(string: "http://static.tvmaze.com/uploads/images/original_untouched/0/1.jpg"))
			XCTAssertEqual(show.schedule.first?.time?.hours, 22)
			XCTAssertEqual(show.schedule.first?.dayOfWeek, .Thursday)
			XCTAssertEqual(show.voteaverage, 6.5)
			XCTAssertEqual(show.episodes.count, 39)
			XCTAssertEqual(show.characters.count, 15)
			XCTAssertEqual(show.crew.count, 27)
		} catch {
			XCTFail(String(describing: error))
		}
	}
}

func resource(atPath path: String, relativeToDirectoryOf file: String = #file) -> URL {
	return URL(fileURLWithPath: file, isDirectory: false).deletingLastPathComponent().appendingPathComponent(path)
}
