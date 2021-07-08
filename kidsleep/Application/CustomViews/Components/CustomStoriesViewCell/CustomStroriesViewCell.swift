import UIKit

@IBDesignable
class CustomStoriesViewCell: UICollectionViewCell {
    static let identifier = "CustomStoriesViewCell"
    
    private var storyTextLabel = UILabel()
    
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
    
    func bind(story: Story) {
        storyTextLabel.text = story.text
    }
    
    private func setup() {
        backgroundColor = UIColor(rgb: 0x191919)
        frame = CGRect(x: 0, y: 0, width: 120, height: 128)
        layer.cornerRadius = 16
        
        let image = UIImage(named: "child")
        let imageView = UIImageView(frame: CGRect(x: 0, y: 16, width: 48, height: 48))
        imageView.contentMode = .scaleAspectFit
        imageView.image = image
        imageView.center.x = bounds.size.width / 2
        
        storyTextLabel = UILabel(frame: CGRect(x: 0, y: imageView.frame.maxY + 3, width: 95, height: 48))
        storyTextLabel.font = UIFont(name: "Montserrat-Medium", size: 11)!
        storyTextLabel.center.x = bounds.size.width / 2
        storyTextLabel.textColor = .white
        storyTextLabel.numberOfLines = 3
        storyTextLabel.textAlignment = .center
        
        addSubview(imageView)
        addSubview(storyTextLabel)
    }
}
