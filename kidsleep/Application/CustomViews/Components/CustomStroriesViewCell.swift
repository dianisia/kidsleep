import UIKit
import SDWebImage

@IBDesignable
class CustomStoriesViewCell: UICollectionViewCell {
    static let identifier = "CustomStoriesViewCell"
    
    private var storyTitleLabel = UILabel()
    private var storyImageView = UIImageView()
    
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
    
    func configure(story: Story) {
        storyTitleLabel.text = story.title
        storyImageView.sd_setImage(with: story.imageURL, completed: nil)
    }
    
    private func setup() {
        backgroundColor = UIColor(rgb: 0x191919)
        frame = CGRect(x: 0, y: 0, width: 120, height: 128)
        layer.cornerRadius = 16
        
        let image = UIImage(named: "child")
        storyImageView = UIImageView(frame: CGRect(x: 0, y: 16, width: 48, height: 48))
        storyImageView.image = image
        storyImageView.center.x = bounds.size.width / 2
        storyImageView.layer.borderWidth = 1
        storyImageView.layer.masksToBounds = false
        storyImageView.layer.borderColor = UIColor.black.cgColor
        storyImageView.layer.cornerRadius = storyImageView.frame.height/2
        storyImageView.clipsToBounds = true
        storyImageView.contentMode = .scaleAspectFill
        
        storyTitleLabel = UILabel(frame: CGRect(x: 0, y: storyImageView.frame.maxY + 3, width: 95, height: 48))
        storyTitleLabel.font = UIFont(name: "Montserrat-Medium", size: 11)!
        storyTitleLabel.center.x = bounds.size.width / 2
        storyTitleLabel.textColor = .white
        storyTitleLabel.numberOfLines = 3
        storyTitleLabel.textAlignment = .center
        
        addSubview(storyImageView)
        addSubview(storyTitleLabel)
    }
}
