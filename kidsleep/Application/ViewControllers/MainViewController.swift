import UIKit
import RxSwift
import RxCocoa

class MainViewController: UIViewController {
    @IBOutlet weak var mainChildCardView: MainChildCard!
    @IBOutlet weak var storiesView: CustomStoriesView!
    @IBOutlet weak var eventsView: CustomEventsView!

    var stories = BehaviorRelay<[Story]>(value: [])

    private let mainViewModel = MainViewModel(serviceProvider: DIContainer.serviceProvider)
    private let storiesViewModel = StoriesViewModel(serviceProvider: DIContainer.serviceProvider)
    private let eventsViewModel = EventsViewModel(serviceProvider: DIContainer.serviceProvider)
    private let storyDetailsViewController = StoryDetailsViewController()
    
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindModels()
    
        storiesView.collectionView.rx.itemSelected
            .subscribe(onNext: { [unowned self] indexPath in
                storyDetailsViewController.configure(with: stories.value)
                storyDetailsViewController.setCurrentStory(tappedStoryIndex: indexPath.row)
                present(storyDetailsViewController, animated: true, completion: nil)
            })
            .disposed(by: bag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    private func bindModels() {
        mainChildCardView.configure(with: mainViewModel.transform())
        eventsView.configure(with: eventsViewModel.transform())
        
        let storiesViewModelOutput = storiesViewModel.transform()
        stories = storiesViewModelOutput.stories
        storiesView.configure(with: storiesViewModelOutput)
    }
}
