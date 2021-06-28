import Foundation
import UIKit

class CustomInput: UITextField {
    let height = 56
    let width = 343
    let leftTextInset: CGFloat = 24
    
    var title = UILabel()
    // MARK:- Properties
    
    override var placeholder: String? {
        didSet {
            title.text = placeholder
            title.sizeToFit()
        }
    }
    
    override var attributedPlaceholder: NSAttributedString? {
        didSet {
            title.text = attributedPlaceholder?.string
            title.sizeToFit()
        }
    }
    
    let textFont: UIFont = UIFont(name: "Montserrat-Bold", size: 16)!
    let titleFont: UIFont = UIFont(name: "Montserrat-Medium", size: 12)!
    
    var titleColor: UIColor = .lightGray
    var hintYPadding: CGFloat = 0.0
    var titleYPadding: CGFloat = 9.0
    var titleActiveTextColour: UIColor! = UIColor.lightGray
    let backColor = UIColor(rgb: 0x181818)
    
    @IBInspectable var rightImage: UIImage? {
        didSet {
            updateView()
        }
    }
    
    // MARK:- Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
        
    }
    
    override init(frame: CGRect) {
        var frameRect = frame;
        frameRect.size.height = CGFloat(height)
        frameRect.size.width = CGFloat(width)
        super.init(frame: frameRect)
        setup()
    }
    
    // MARK:- Overrides
    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        var r = super.textRect(forBounds: bounds)
        r = r.inset(by: UIEdgeInsets(top: 0, left: leftTextInset, bottom: 0.0, right: 10.0))
        
        if let txt = text, !txt.isEmpty {
            var top = ceil(title.font.lineHeight + hintYPadding)
            top = min(top, maxTopInset())
            r = r.inset(by: UIEdgeInsets(top: top, left: 0.0, bottom: 0.0, right: 10.0))
        }
        return r.integral
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        var r = super.editingRect(forBounds: bounds)
        r = r.inset(by: UIEdgeInsets(top: 0, left: leftTextInset, bottom: 0.0, right: 0.0))
        
        if let txt = text, !txt.isEmpty {
            var top = ceil(title.font.lineHeight + hintYPadding)
            top = min(top, maxTopInset())
            r = r.inset(by: UIEdgeInsets(top: top, left: 0.0, bottom: 0.0, right: 0.0))
        }
        return r.integral
    }
    
    override func clearButtonRect(forBounds bounds: CGRect) -> CGRect {
        var r = super.clearButtonRect(forBounds: bounds)
        if let txt = text , !txt.isEmpty {
            var top = ceil(title.font.lineHeight + hintYPadding)
            top = min(top, maxTopInset())
            r = CGRect(x: r.origin.x, y: r.origin.y + (top * 0.5), width: r.size.width, height:r.size.height)
        }
        return r.integral
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.rightViewRect(forBounds: bounds)
        textRect.size.height = CGFloat(24)
        textRect.size.width = CGFloat(24)
        textRect.origin.x -= 16
        return textRect
    }
    
    // MARK:- Private Methods
    
    func updateView() {
        if let image = rightImage {
            rightViewMode = UITextField.ViewMode.always
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
            imageView.contentMode = .scaleAspectFill
            imageView.image = image
            let view = UIView()
            view.addSubview(imageView)
            rightView = view
        } else {
            rightViewMode = UITextField.ViewMode.never
            rightView = nil
        }
    }

    fileprivate func setup() {
//        var frameRect = frame;
//        frameRect.size.height = CGFloat(height)
//        frameRect.size.width = CGFloat(width)
//        frame = frameRect;
        
        backgroundColor = backColor
        borderStyle = UITextField.BorderStyle.none
        layer.cornerRadius = 10
        textColor = .white
        
        let placeholderFontAttribute = [
            NSAttributedString.Key.font: UIFont(name: "Montserrat-Medium", size: 14)!,
            NSAttributedString.Key.foregroundColor: UIColor.lightGray
        ]
        attributedPlaceholder = NSAttributedString(
            string: placeholder ?? "",
            attributes: placeholderFontAttribute
        )
        title.alpha = 0.0
        title.font = titleFont
        title.textColor = .white
        if let str = placeholder, !str.isEmpty {
            title.text = str
            title.sizeToFit()
        }
        font = textFont
        self.addSubview(title)
        
        setTitlePositionForTextAlignment()
        let isResp = isFirstResponder
        if let txt = text, !txt.isEmpty && isResp {
            title.textColor = titleActiveTextColour
        } else {
            title.textColor = titleColor
        }
        
        if let txt = text, txt.isEmpty {
            hideTitle(isResp)
        } else {
            showTitle(isResp)
        }
    }
    
    fileprivate func maxTopInset() -> CGFloat {
        if let fnt = font {
            return max(0, floor(bounds.size.height - fnt.lineHeight - 23.0))
        }
        return 0
    }
    
    fileprivate func setTitlePositionForTextAlignment() {
        let r = textRect(forBounds: bounds)
        var x = r.origin.x
        if textAlignment == NSTextAlignment.center {
            x = r.origin.x + (r.size.width * 0.5) - title.frame.size.width
        } else if textAlignment == NSTextAlignment.right {
            x = r.origin.x + r.size.width - title.frame.size.width
        }
        title.frame = CGRect(x: x, y: title.frame.origin.y, width: title.frame.size.width, height: title.frame.size.height)
    }
    
    fileprivate func showTitle(_ animated: Bool) {
        self.title.alpha = 1.0
        var r = self.title.frame
        r.origin.y = self.titleYPadding
        self.title.frame = r
    }
    
    fileprivate func hideTitle(_ animated: Bool) {
        self.title.alpha = 0.0
        var r = self.title.frame
        r.origin.y = self.title.font.lineHeight + self.hintYPadding
        self.title.frame = r
    }
}
