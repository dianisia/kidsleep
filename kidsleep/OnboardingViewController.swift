import UIKit

class OnboardingViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
//        self.collectionView.register(UINib(nibName: "MainChildInfoView", bundle: nil), forCellWithReuseIdentifier: "cell")
        self.collectionView.register(UINib(nibName: "ScheduleInfoView", bundle: nil), forCellWithReuseIdentifier: "cell")
        super.viewDidLoad()
    }
}

extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : ScheduleInfoView = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ScheduleInfoView
        cell.scrollView?.contentMode = .scaleAspectFit
        cell.scrollView?.delegate = self
        cell.scrollView?.contentSize = cell.frame.size
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
}
