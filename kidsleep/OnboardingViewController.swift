import UIKit
import Foundation

class OnboardingViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageController: CustomPageControl!
    @IBOutlet weak var informationLabel: UILabel!
    
    private var currentPage = 0 {
        didSet {
            pageController.currentPage = currentPage
            setInformationLabelText(currentPage: currentPage)
        }
    }
    
    private var onboardingScreens: [UICollectionViewCell] = []
    
    private var onboardingScreensInfo = [
        (xib: "MainChildInfoView", cell: "cell_info"),
        (xib: "ScheduleInfoView", cell: "cell_schedule"),
        (xib: "SongsInfoView", cell: "cell_songs"),
    ]
    
    override func viewDidLoad() {
        onboardingScreensInfo.forEach { screenInfo in
            self.collectionView.register(UINib(nibName: screenInfo.xib, bundle: nil), forCellWithReuseIdentifier: screenInfo.cell)
        }
        
        onboardingScreens.append(collectionView.dequeueReusableCell(withReuseIdentifier: onboardingScreensInfo[0].cell, for: IndexPath(item: 0, section: 0)) as! MainChildInfoView)
        
        onboardingScreens.append(collectionView.dequeueReusableCell(withReuseIdentifier: onboardingScreensInfo[1].cell, for: IndexPath(item: 1, section: 0)) as! ScheduleInfoView)
        
        onboardingScreens.append(collectionView.dequeueReusableCell(withReuseIdentifier: onboardingScreensInfo[2].cell, for: IndexPath(item: 2, section: 0)) as! SongsInfoView)
        
        super.viewDidLoad()
        currentPage = 0
        
    }
    
    @IBAction func onNextClicked(_ sender: Any) {
        currentPage += 1
        let indexPath = IndexPath(item: currentPage, section: 0)
        collectionView.isPagingEnabled = false
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        collectionView.isPagingEnabled = true
    }
    
    private func setInformationLabelText(currentPage: Int) {
        switch currentPage {
        case 0:
            informationLabel.text = "Расскажите нам о своих детях, чтобы мы могли предложить рекомендуемый режим сна для них"
        case 1:
            informationLabel.text = "Для ребенка возрастом от 1 года, мы рекомендуем такой распорядок дня, но вы можете отредактировать его:"
        case 2:
            informationLabel.text = "Мы поможем вам укладывать ребенка спать с помощью подборки успокаивающих звуков, советов и подсказок"
        default:
            informationLabel.text = "Zzzzz..."
        }
    }
}

extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return onboardingScreens[indexPath.item]

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
    }
}
