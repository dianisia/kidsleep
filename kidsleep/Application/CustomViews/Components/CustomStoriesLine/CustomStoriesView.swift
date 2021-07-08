import UIKit
import RxSwift
import RxCocoa

@IBDesignable
class CustomStoriesView: UIView, UIScrollViewDelegate {
    private let bag = DisposeBag()
    
    var collectionView: UICollectionView!
    var stories: Observable<[Story]> = Observable.empty()
    
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
    }
    
    private func setup() {
        backgroundColor = .black
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        layout.itemSize = CGSize(width: 120, height: 128)
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height), collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(CustomStoriesViewCell.self, forCellWithReuseIdentifier: CustomStoriesViewCell.identifier)
        addSubview(collectionView)
        collectionView.rx.setDelegate(self).disposed(by: bag)
    }
    
    func configure(with viewModel: StoriesViewModel) {
        let output = viewModel.transform(input: StoriesViewModel.Input())
        output.stories.bind(to: collectionView.rx.items(cellIdentifier: CustomStoriesViewCell.identifier, cellType: CustomStoriesViewCell.self)) { row, data, cell in
            cell.configure(story: data)
        }
        .disposed(by: bag)
    }
}
