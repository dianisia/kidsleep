import UIKit

class HelpersViewController: UIViewController {
    @IBOutlet weak var nighLightButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    @IBAction func turnOnLightTapped(_ sender: Any) {
        let nightLighViewController = NightLightViewController()
        presentPanModal(nightLighViewController)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nighLightButton.layer.cornerRadius = 16
    }
}
