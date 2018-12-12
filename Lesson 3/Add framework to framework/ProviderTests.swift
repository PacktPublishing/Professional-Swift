import XCTest
import Moya
import TVShows

class ProviderTests: XCTestCase {
	func testGetUser() {
		let provider = MoyaProvider<TVMaze>()
		let expectation = self.expectation(description: "Will return with JSON.")

		provider.request(.getUser(id: 2)) { result in
			switch result {
			case let .success(moyaResponse):
				do {
					let person = try moyaResponse.map(Person.self)

					XCTAssertEqual(person.name, "Rachelle Lefevre")
					XCTAssertEqual(person.id, 2)
					expectation.fulfill()
				} catch {
					XCTFail("\(error)\n\n\(String(data: moyaResponse.data, encoding: .utf8)!)")
				}
			case let .failure(error):
				// this means there was a network failure - either the request wasn't sent (connectivity), or no response was received (server timed out). If the server responds with a 4xx or 5xx error, that will be sent as a ".success"-ful response.
				XCTFail("\(error)")
			}
		}
		waitForExpectations(timeout: 2, handler: nil)
	}

	func testGetShow() {
		let provider = MoyaProvider<TVMaze>()
		let expectation = self.expectation(description: "Will return with JSON.")

		provider.request(.getShow(id: 2)) { result in
			do {
				let decoder = JSONDecoder()
				decoder.dateDecodingStrategy = .iso8601
				let show = try result.dematerialize().map(Show.self, using: decoder)

				XCTAssertEqual(show.name, "Person of Interest")
				XCTAssertEqual(show.id, 2)
				XCTAssertEqual(show.episodes.count, 103)
				XCTAssertEqual(show.characters.count, 7)
				XCTAssertEqual(show.crew.count, 43)
				expectation.fulfill()
			} catch {
				XCTFail("\(error)")
			}
		}
		waitForExpectations(timeout: 2, handler: nil)
	}

	func testSearchShows() {
		let expectation = self.expectation(description: "Will return with JSON.")

		Show.search("Office") { result in
			do {
				let shows = try result.dematerialize()
				XCTAssertEqual(shows.count, 10)
				XCTAssertEqual(shows.first?.name, "The Office")
				expectation.fulfill()
			} catch {
				XCTFail("\(error)")
			}
		}
		waitForExpectations(timeout: 2, handler: nil)
	}
}
