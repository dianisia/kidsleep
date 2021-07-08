import UIKit

@IBDesignable
class CustomStoriesLine: UIView {
    
    private var collectionView: UICollectionView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }
    
    private func setup() {
        backgroundColor = .black
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
        layout.itemSize = CGSize(width: 120, height: 128)
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height), collectionViewLayout: layout)
        
        collectionView.register(CustomStoriesViewCell.self, forCellWithReuseIdentifier: CustomStoriesViewCell.identifier)
        addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension CustomStoriesLine: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomStoriesViewCell.identifier, for: indexPath) as? CustomStoriesViewCell else {
            return UICollectionViewCell()
        }
        return cell
    }
}
