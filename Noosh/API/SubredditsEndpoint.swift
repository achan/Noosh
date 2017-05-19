import reddift

protocol SubredditsEndpoint {
	func getList(
		where subredditsWhere: SubredditsWhere,
		paginator: Paginator?,
		completion: @escaping (Result<Listing>) -> Void
	) throws -> URLSessionTask

}

class SubredditsEndpointImpl: SubredditsEndpoint {
	private let session: Session

	init(session: Session) {
		self.session = session
	}

	func getList(
		where subredditsWhere: SubredditsWhere,
		paginator: Paginator?,
		completion: @escaping (Result<Listing>) -> Void
	) throws -> URLSessionTask {
		return try session.getSubreddit(subredditsWhere, paginator: paginator, completion: completion)
	}
}
