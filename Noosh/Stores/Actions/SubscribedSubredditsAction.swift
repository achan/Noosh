import reddift
import RxSwift

protocol SubscribedSubredditsAction {
	typealias PaginatedSubreddits = [Subreddit]

	var subreddits: Observable<PaginatedSubreddits> { get }
	func call()
}
