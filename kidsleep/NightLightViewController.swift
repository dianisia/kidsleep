import UIKit
import PanModal

class NightLightViewController: UIViewController {
    private let sliderWidth = 129
    private let sliderHeight = 330
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "Яркость ночника"
        label.textColor = UIColor(rgb: 0x6634F5)
        label.font = UIFont(name: "Montserrat-SemiBold", size: 18)!
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
    
        let slider: CustomSlider = CustomSlider(
            frame: CGRect(
                x: Int(view.frame.width) / 2 - sliderWidth / 2,
                y: 80,
                width: sliderWidth,
                height: sliderHeight
            ),
                selectedSection: 3,
                sections: 10
        )
        
        view.addSubview(slider)
        view.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
}

extension NightLightViewController: PanModalPresentable {
    var panScrollable: UIScrollView? {
        return nil
    }
    
    var shortFormHeight: PanModalHeight {
        return .contentHeight(500)
    }
    
//    func panModalWillDismiss() {
//        closePanel?()
//    }
}
