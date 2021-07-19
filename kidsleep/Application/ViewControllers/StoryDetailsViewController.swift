import Foundation
import UIKit
import RxSwift
import RxCocoa
import SDWebImage

class StoryDetailsViewController: UIViewController {
    private let bag = DisposeBag()
    
    private var headerLabel = UILabel()
    private var imageView = UIImageView()
    private var textLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Montserrat-Medium", size: 14)!
        lbl.textColor = UIColor.white
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Montserrat-Bold", size: 24)!
        lbl.textColor = UIColor(rgb: 0x6634F5)
        lbl.numberOfLines = 0
        return lbl
    }()
    private var stories = [Story]()
    private var currentStory = 0
    
    override func viewDidLoad() {
        view.backgroundColor = .black
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap(_:))))
        //        let countDown = 10
        //        Observable<Int>.timer(.seconds(0), period: .seconds(1), scheduler: MainScheduler.instance)
        //                .take(countDown+1)
        //                .subscribe(onCompleted: { [unowned self] in
        //                    print("count down complete")
        //                    dismiss(animated: true, completion: nil)
        //                })
        //            .disposed(by: bag)
        setup()
    }
    
    @objc private func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        currentStory += 1
        if (currentStory == self.stories.count) {
            dismiss(animated: true, completion: nil)
            return
        }
        showContentForCurrentStory()
    }
    
    func configure(with stories: [Story]) {
        self.stories = stories
    }
    
    func setCurrentStory(tappedStoryIndex: Int) {
        currentStory = tappedStoryIndex
        showContentForCurrentStory()
    }
    
    private func setup() {
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        
        view.addSubview(textLabel)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16).isActive = true
        textLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        textLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        
        view.addSubview(imageView)
        imageView.image = UIImage(named: "big_child")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 16).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        imageView.contentMode = .scaleAspectFit
    }
    
    private func showContentForCurrentStory() {
        textLabel.text = stories[currentStory].text
        titleLabel.text = stories[currentStory].title
    }
}
