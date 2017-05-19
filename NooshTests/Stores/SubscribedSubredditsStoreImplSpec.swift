import Quick
import Nimble
import RxSwift
import reddift
import RxBlocking

@testable import Noosh

class SubscribedSubredditsStoreImplSpec: QuickSpec {
	override func spec() {
		describe("all()") {
			var store: SubscribedSubredditsStoreImpl!
			var subredditPages: [[Subreddit]]!
			var subject: Observable<[Subreddit]>!
			var disposeBag: DisposeBag!

			beforeEach {
				subredditPages = [
					SubredditFactory().buildList(3),
					SubredditFactory().buildList(3)
				]

				store = SubscribedSubredditsStoreImpl(
					client: MockClient(),
					subscribedSubredditsAction: MockSubscribedSubredditsAction(subredditPages: subredditPages)
				)

				subject = store.subreddits

				disposeBag = DisposeBag()
			}

			it("returns an observable of all subscribed subreddits") {
				var results: [[Subreddit]] = []

				subject
					.subscribe { results.append($0.element!) }
					.addDisposableTo(disposeBag)

				store.all()

				expect(results[0]).to(beEmpty())
				expect(results[1].map { $0.displayName })
					.toEventually(equal(subredditPages.flatMap { $0 }.map { $0.displayName }))
			}
		}
	}
}

class MockSubredditStore: SubredditStore {
	var subredditsAdded: [Subreddit]

	init() {
		subredditsAdded = []
	}

	func add(_ subreddit: Subreddit) {
		subredditsAdded.append(subreddit)
	}
}

class MockSessionDataTask: SessionDataTask {
	var resumed: Bool = false

	func resume() {
		resumed = true
	}
}

class MockClient: RedditClient {
	func getSubreddit(
		where subredditWhere: SubredditsWhere,
		paginator: Paginator?,
		completion: @escaping (Result<Listing>) -> Void
		) throws -> SessionDataTask {
		return MockSessionDataTask()
	}
}

class MockSubscribedSubredditsAction: SubscribedSubredditsAction {
	var subredditPages: [[Subreddit]]

	private let subredditsSubject: BehaviorSubject<PaginatedSubreddits>

	var subreddits: Observable<SubscribedSubredditsAction.PaginatedSubreddits> {
		return subredditsSubject.asObservable()
	}

	init(subredditPages: [[Subreddit]]) {
		self.subredditPages = subredditPages
		self.subredditsSubject = BehaviorSubject(value: [])
	}

	func call() {
		subredditPages.forEach { subredditsSubject.onNext($0) }
		subredditsSubject.onCompleted()
	}
}
