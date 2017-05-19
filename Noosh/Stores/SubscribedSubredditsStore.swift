import RxSwift
import reddift

protocol SubscribedSubredditsStore {
    var subreddits: Observable<[Subreddit]> { get }
    func all()
}

class SubscribedSubredditsStoreImpl: SubscribedSubredditsStore {
    private let client: RedditClient
    private let disposeBag: DisposeBag
    private let subscribedSubredditsAction: SubscribedSubredditsAction
    private let subredditsSubject: BehaviorSubject<[Subreddit]>

    var subreddits: Observable<[Subreddit]> {
        return subredditsSubject.asObservable()
    }

    init(
        client: RedditClient,
        subscribedSubredditsAction: SubscribedSubredditsAction
        ) {
        self.client = client
        self.subscribedSubredditsAction = subscribedSubredditsAction

        subredditsSubject = BehaviorSubject(value: [])
        disposeBag = DisposeBag()
    }

    func all() {
        var fetchedSubreddits: [Subreddit] = []
        subscribedSubredditsAction.subreddits.subscribe { [weak subredditsSubject] event in
            switch event {
            case .next(let page):
                fetchedSubreddits.append(contentsOf: page)
            case .completed:
                subredditsSubject?.onNext(fetchedSubreddits)
            case .error:
                break;
            }
            }.addDisposableTo(disposeBag)

        subscribedSubredditsAction.call()
    }
}
