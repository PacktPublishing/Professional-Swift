// Generated using Sourcery 0.9.0 — https://github.com/krzysztofzablocki/Sourcery

// MARK: Character Equatable
extension Character: Equatable {
	static func ==(lhs: Character, rhs: Character) -> Bool {
		guard lhs.id == rhs.id else { return false }
		guard lhs.name == rhs.name else { return false }
		guard lhs.summary == rhs.summary else { return false }
		guard lhs.image == rhs.image else { return false }
		guard lhs.actor == rhs.actor else { return false }
		return true
	}
}
// MARK: Episode Equatable
extension Episode: Equatable {
	static func ==(lhs: Episode, rhs: Episode) -> Bool {
		guard lhs.id == rhs.id else { return false }
		guard lhs.name == rhs.name else { return false }
		guard lhs.summary == rhs.summary else { return false }
		guard lhs.season == rhs.season else { return false }
		guard lhs.episodeNumber == rhs.episodeNumber else { return false }
		guard lhs.firstAiredAt == rhs.firstAiredAt else { return false }
		return true
	}
}
// MARK: Person Equatable
extension Person: Equatable {
	static func ==(lhs: Person, rhs: Person) -> Bool {
		guard lhs.id == rhs.id else { return false }
		guard lhs.name == rhs.name else { return false }
		guard lhs.summary == rhs.summary else { return false }
		guard lhs.countryofbirth == rhs.countryofbirth else { return false }
		return true
	}
}
// MARK: ScheduleTime Equatable
extension ScheduleTime: Equatable {
	static func ==(lhs: ScheduleTime, rhs: ScheduleTime) -> Bool {
		guard lhs.time?.hours == rhs.time?.hours else { return false }
		guard lhs.time?.minutes == rhs.time?.minutes else { return false }
		guard lhs.dayOfWeek == rhs.dayOfWeek else { return false }
		return true
	}
}
// MARK: Show Equatable
extension Show: Equatable {
	static func ==(lhs: Show, rhs: Show) -> Bool {
		guard lhs.id == rhs.id else { return false }
		guard lhs.name == rhs.name else { return false }
		guard lhs.summary == rhs.summary else { return false }
		guard lhs.image == rhs.image else { return false }
		guard lhs.status == rhs.status else { return false }
		guard lhs.showtype == rhs.showtype else { return false }
		guard lhs.length == rhs.length else { return false }
		guard lhs.schedule == rhs.schedule else { return false }
		guard lhs.genres == rhs.genres else { return false }
		guard lhs.officialSite == rhs.officialSite else { return false }
		guard lhs.airsOn == rhs.airsOn else { return false }
		guard lhs.voteaverage == rhs.voteaverage else { return false }
		guard lhs.crew.elementsEqual(rhs.crew, by: ==) else { return false }
		guard lhs.characters == rhs.characters else { return false }
		guard lhs.episodes == rhs.episodes else { return false }
		return true
	}
}
