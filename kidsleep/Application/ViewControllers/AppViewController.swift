import UIKit
import RxSwift
import RxCocoa

class AppViewController: UIViewController {
    @IBOutlet weak var mainChildCardView: MainChildCard!
    @IBOutlet weak var storiesView: CustomStoriesView!
    @IBOutlet weak var eventsView: CustomEventsView!

    var stories = BehaviorRelay<[Story]>(value: [])
    
    private let viewModel: MainViewModel = MainViewModel()
    private let storiesViewModel: StoriesViewModel = StoriesViewModel()
    private let eventsViewModel: EventsViewModel = EventsViewModel()
    private let storyDetailsViewController = StoryDetailsViewController()
    
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventsView.configure(with: eventsViewModel)
        bindModel()
    
        storiesView.collectionView.rx.itemSelected
            .subscribe(onNext: { [unowned self]indexPath in
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
    
    private func bindModel() {
        let output = viewModel.transform()
        
        output.name.drive(mainChildCardView.nameLabel.rx.text)
            .disposed(by: bag)
        output.age.drive(mainChildCardView.ageLabel.rx.text)
            .disposed(by: bag)
        output.nextEvent.drive(onNext: {[unowned self] event in
            mainChildCardView.eventType = event.0
            mainChildCardView.minutesToNextEvent = event.1
        })
        .disposed(by: bag)
        
        stories = storiesViewModel.transform().stories
        storiesView.configure(with: stories)
        
    }
}
