import UIKit
import RxSwift
import RxCocoa

class AppViewController: UIViewController {
    @IBOutlet weak var mainChildCardView: MainChildCard!
    private let viewModel: MainViewModel = MainViewModel()
    
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
            print(event)
            mainChildCardView.eventType = event.0
            mainChildCardView.minutesToNextEvent = event.1
        })
        .disposed(by: bag)
    }
}
