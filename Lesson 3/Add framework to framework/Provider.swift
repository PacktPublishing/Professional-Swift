import Moya
import Foundation

public enum TVMaze {
	case getUser(id: Int)
	case getShow(id: Int)
	case searchShows(text: String)
}

extension TVMaze: TargetType {
	public var baseURL: URL { return URL(string: "https://api.tvmaze.com")! }
	public var path: String {
		switch self {
		case .getUser(let id):
			return "/people/\(id)"
		case .getShow(let id):
			return "/shows/\(id)"
		case .searchShows(_):
			return "/search/shows"
		}
	}
	public var method: Moya.Method { return .get }
	public var task: Task {
		switch self {
		case .getUser(_):
			return .requestPlain
		case .getShow(_):
			return .requestParameters(parameters: ["embed[0]": "episodes", "embed[1]": "cast", "embed[2]": "crew"], encoding: URLEncoding.queryString)
		case .searchShows(let text):
			return .requestParameters(parameters: ["q": text], encoding: URLEncoding.queryString)
		}
	}
	public var sampleData: Data {
		switch self {
		case .getUser(let id):
			return """
				{
				"id": \(id),
				"url": "http://www.tvmaze.com/people/\(id)/mike-vogel",
				"name": "Mike Vogel",
				"image": {
					"medium": "http://static.tvmaze.com/uploads/images/medium_portrait/0/1815.jpg",
					"original": "http://static.tvmaze.com/uploads/images/original_untouched/0/1815.jpg"
				},
				"_links": {
					"self": {
						"href": "http://api.tvmaze.com/people/\(id)"
						}
					}
				}
				""".data(using: .utf8)!
		default:
			return Data()
		}
	}
	public var headers: [String: String]? {
		return ["Content-type": "application/json"]
	}
}

struct SearchResults: Codable {
	let score: Double
	let show: Show
}

import Result

extension Show {
	public static func search(_ searchText: String, completion: @escaping (Result<[Show], AnyError>) -> Void) {
		let provider = MoyaProvider<TVMaze>()

		provider.request(.searchShows(text: searchText)) { result in
			do {
				let decoder = JSONDecoder()
				decoder.dateDecodingStrategy = .iso8601
				let shows = try result.dematerialize().map([SearchResults].self, using: decoder)
					.map { $0.show }
				completion(.success(shows))
			} catch {
				completion(.failure(AnyError(error)))
			}
		}
	}
}
