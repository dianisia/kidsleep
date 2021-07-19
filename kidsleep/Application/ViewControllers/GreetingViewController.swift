import UIKit
import RxSwift
import RxCocoa

class GreetingViewController: UIViewController {
    @IBOutlet weak var startButton: CustomButton!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startButton.rx.tap.bind { [unowned self] in
            let storyboard = UIStoryboard(name: "Onboarding", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "OnboardingViewController") as! OnboardingViewController
            vc.modalPresentationStyle = .overCurrentContext
            self.present(vc, animated: true, completion: nil)
        }
        .disposed(by: disposeBag)
    }
}

