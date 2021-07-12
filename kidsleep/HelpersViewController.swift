import UIKit

class HelpersViewController: UIViewController {
    @IBOutlet weak var nighLightButton: UIButton!
    
    @IBAction func turnOnLightTapped(_ sender: Any) {
        let nightLighViewController = NightLightViewController()
        presentPanModal(nightLighViewController)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nighLightButton.layer.cornerRadius = 16
    }
}
