import UIKit
import RxSwift
import RxCocoa

class AppViewController: UIViewController {
    @IBOutlet weak var mainChildCardView: MainChildCard!
    @IBOutlet weak var storiesView: CustomStoriesView!
    
    private let viewModel: MainViewModel = MainViewModel()
    private let storiesViewModel: StoriesViewModel = StoriesViewModel()
    
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        storiesView.configure(with: storiesViewModel)
        bindModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    private func bindModel() {
        let output = viewModel.transform(input: MainViewModel.Input())
        
        output.name.drive(mainChildCardView.nameLabel.rx.text)
            .disposed(by: bag)
        output.age.drive(mainChildCardView.ageLabel.rx.text)
            .disposed(by: bag)
        output.nextEvent.drive(onNext: {[unowned self] event in
            mainChildCardView.eventType = event.0
            mainChildCardView.minutesToNextEvent = event.1
        })
        .disposed(by: bag)
    }
}
