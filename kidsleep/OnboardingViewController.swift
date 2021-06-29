import UIKit
import Foundation

class OnboardingViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageController: CustomPageControl!
    
    private var currentPage = 0 {
        didSet {
            pageController.currentPage = currentPage
        }
    }
    var mainChildInfoCell: MainChildInfoView = MainChildInfoView()
    var scheduleInfoCell: ScheduleInfoView = ScheduleInfoView()
    
    override func viewDidLoad() {
        self.collectionView.register(UINib(nibName: "MainChildInfoView", bundle: nil), forCellWithReuseIdentifier: "cell_info")
        self.collectionView.register(UINib(nibName: "ScheduleInfoView", bundle: nil), forCellWithReuseIdentifier: "cell_schedule")
        
        mainChildInfoCell  = collectionView.dequeueReusableCell(withReuseIdentifier: "cell_info", for: IndexPath(item: 0, section: 0)) as! MainChildInfoView
        
        scheduleInfoCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell_schedule", for: IndexPath(item: 1, section: 0)) as! ScheduleInfoView
        
        super.viewDidLoad()
        currentPage = 0
        
    }
    
    @IBAction func onNextClicked(_ sender: Any) {
        let indexPath = IndexPath(item: 1, section: 0)
        collectionView.isPagingEnabled = false
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        collectionView.isPagingEnabled = true
        currentPage += 1
    }
}

extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        2
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (indexPath.item == 0) {
            return mainChildInfoCell
        }
        else if (indexPath.item == 1) {
            return scheduleInfoCell
        }

        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
    }
}
