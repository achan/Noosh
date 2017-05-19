import reddift

protocol RedditClient {
	func getSubreddit(
		where subredditWhere: SubredditsWhere,
		paginator: Paginator?,
		completion: @escaping (Result<Listing>) -> Void
	) throws -> SessionDataTask
}

class ProductionRedditClient: RedditClient {
	private let session: Session

	init(session: Session) {
		self.session = session
	}

	func getSubreddit(
		where subredditWhere: SubredditsWhere,
		paginator: Paginator?,
		completion: @escaping (Result<Listing>) -> Void
	) throws -> SessionDataTask {
		return try session.getSubreddit(subredditWhere, paginator: paginator, completion: completion)
	}
}

protocol SessionDataTask {
	func resume()
}

extension URLSessionDataTask: SessionDataTask {
}
