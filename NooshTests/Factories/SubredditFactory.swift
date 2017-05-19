import reddift
import Fakery

class SubredditFactory {
	enum Fields {
		case displayName
	}

	private let faker = Faker()

	private var defaultOptions: [Fields : Any] {
		return [
			.displayName : self.faker.lorem.word()
		]
	}

	func build(_ options: [Fields : Any] = [:]) -> Subreddit {
		var options = defaultOptions.merge(options)
		return Subreddit(subreddit: options[.displayName] as! String)
	}

	func buildList(_ count: Int, options: [Fields : Any] = [:]) -> [Subreddit] {
		var list: [Subreddit] = []

		for _ in 0..<count {
			list.append(build(options))
		}

		return list
	}
}
