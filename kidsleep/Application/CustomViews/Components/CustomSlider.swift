import Foundation
import UIKit

public protocol SectionedSliderDelegate {
    func sectionChanged(slider: CustomSlider, selected: Int)
}

public class StyleKit : NSObject {

    //// Drawing Methods
    public static func drawSlider(frame targetFrame: CGRect = CGRect(x: 0, y: 0, width: 156, height: 400), resizing: ResizingBehavior = .aspectFit, factor: CGFloat = 0.0, sections: CGFloat = 10, palette: Palette = Palette()) {
        
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()!

        let sectionOriginalHeight: CGFloat = 400
        let sectionOriginalWidth: CGFloat = 156
        
        //// Resize to Target Frame
        context.saveGState()
        let resizedFrame: CGRect = resizing.apply(rect: CGRect(x: 0, y: 0, width: sectionOriginalWidth, height: sectionOriginalHeight), target: targetFrame)
        context.translateBy(x: resizedFrame.minX, y: resizedFrame.minY)
        context.scaleBy(x: resizedFrame.width / sectionOriginalWidth, y: resizedFrame.height / sectionOriginalHeight)

        //// Variable Declarations
        let sectionsSafe: CGFloat = sections < 2 ? 2 : (sections > 20 ? 20 : sections)
        let sectionHeight: CGFloat = sectionOriginalHeight / sectionsSafe
        let slideHeight: CGFloat = floor(factor / (1.0 / sectionsSafe) + 1) * sectionHeight

        //// BackgroundView Drawing
        let backgroundViewPath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: sectionOriginalWidth, height: sectionOriginalHeight))
        palette.viewBackgroundColor.setFill()
        backgroundViewPath.fill()
        
        //// BodyBackgroundView Drawing
        let bodyBackgroundViewPath = UIBezierPath()
        bodyBackgroundViewPath.move(to: CGPoint(x: 76.43, y: 0))
        bodyBackgroundViewPath.addLine(to: CGPoint(x: 79.57, y: 0))
        bodyBackgroundViewPath.addCurve(to: CGPoint(x: 122.5, y: 3.27), controlPoint1: CGPoint(x: 101.58, y: 0), controlPoint2: CGPoint(x: 112.58, y: 0))
        bodyBackgroundViewPath.addLine(to: CGPoint(x: 124.43, y: 3.75))
        bodyBackgroundViewPath.addCurve(to: CGPoint(x: 152.25, y: 31.57), controlPoint1: CGPoint(x: 137.36, y: 8.45), controlPoint2: CGPoint(x: 147.55, y: 18.64))
        bodyBackgroundViewPath.addCurve(to: CGPoint(x: 156, y: 76.43), controlPoint1: CGPoint(x: 156, y: 43.42), controlPoint2: CGPoint(x: 156, y: 54.42))
        bodyBackgroundViewPath.addLine(to: CGPoint(x: 156, y: 323.57))
        bodyBackgroundViewPath.addCurve(to: CGPoint(x: 152.73, y: 366.5), controlPoint1: CGPoint(x: 156, y: 345.58), controlPoint2: CGPoint(x: 156, y: 356.58))
        bodyBackgroundViewPath.addLine(to: CGPoint(x: 152.25, y: 368.43))
        bodyBackgroundViewPath.addCurve(to: CGPoint(x: 124.43, y: 396.25), controlPoint1: CGPoint(x: 147.55, y: 381.36), controlPoint2: CGPoint(x: 137.36, y: 391.55))
        bodyBackgroundViewPath.addCurve(to: CGPoint(x: 79.57, y: 400), controlPoint1: CGPoint(x: 112.58, y: 400), controlPoint2: CGPoint(x: 101.58, y: 400))
        bodyBackgroundViewPath.addLine(to: CGPoint(x: 76.43, y: 400))
        bodyBackgroundViewPath.addCurve(to: CGPoint(x: 33.5, y: 396.73), controlPoint1: CGPoint(x: 54.42, y: 400), controlPoint2: CGPoint(x: 43.42, y: 400))
        bodyBackgroundViewPath.addLine(to: CGPoint(x: 31.57, y: 396.25))
        bodyBackgroundViewPath.addCurve(to: CGPoint(x: 3.75, y: 368.43), controlPoint1: CGPoint(x: 18.64, y: 391.55), controlPoint2: CGPoint(x: 8.45, y: 381.36))
        bodyBackgroundViewPath.addCurve(to: CGPoint(x: 0, y: 323.57), controlPoint1: CGPoint(x: 0, y: 356.58), controlPoint2: CGPoint(x: 0, y: 345.58))
        bodyBackgroundViewPath.addLine(to: CGPoint(x: 0, y: 76.43))
        bodyBackgroundViewPath.addCurve(to: CGPoint(x: 3.27, y: 33.5), controlPoint1: CGPoint(x: 0, y: 54.42), controlPoint2: CGPoint(x: 0, y: 43.42))
        bodyBackgroundViewPath.addLine(to: CGPoint(x: 3.75, y: 31.57))
        bodyBackgroundViewPath.addCurve(to: CGPoint(x: 31.57, y: 3.75), controlPoint1: CGPoint(x: 8.45, y: 18.64), controlPoint2: CGPoint(x: 18.64, y: 8.45))
        bodyBackgroundViewPath.addCurve(to: CGPoint(x: 76.43, y: 0), controlPoint1: CGPoint(x: 43.42, y: -0), controlPoint2: CGPoint(x: 54.42, y: 0))
        bodyBackgroundViewPath.close()
        palette.sliderBackgroundColor.setFill()
        bodyBackgroundViewPath.fill()
        
        //// Group
        context.saveGState()
        context.beginTransparencyLayer(auxiliaryInfo: nil)
        
        //// SectionedMask Drawing
        context.saveGState()
        context.translateBy(x: 78, y: 200)
        context.rotate(by: -180 * CGFloat.pi/180)
        
        let sectionedMaskPath = UIBezierPath(rect: CGRect(x: -78, y: -200, width: sectionOriginalWidth, height: slideHeight))
        palette.sliderColor.setFill()
        sectionedMaskPath.fill()
        
        context.restoreGState()
        
        //// BodyView Drawing
        context.saveGState()
        context.setBlendMode(.sourceIn)
        context.beginTransparencyLayer(auxiliaryInfo: nil)
        
        let bodyViewPath = UIBezierPath()
        bodyViewPath.move(to: CGPoint(x: 76.43, y: 0))
        bodyViewPath.addLine(to: CGPoint(x: 79.57, y: 0))
        bodyViewPath.addCurve(to: CGPoint(x: 122.5, y: 3.27), controlPoint1: CGPoint(x: 101.58, y: 0), controlPoint2: CGPoint(x: 112.58, y: -0))
        bodyViewPath.addLine(to: CGPoint(x: 124.43, y: 3.75))
        bodyViewPath.addCurve(to: CGPoint(x: 152.25, y: 31.57), controlPoint1: CGPoint(x: 137.36, y: 8.45), controlPoint2: CGPoint(x: 147.55, y: 18.64))
        bodyViewPath.addCurve(to: CGPoint(x: 156, y: 76.43), controlPoint1: CGPoint(x: 156, y: 43.42), controlPoint2: CGPoint(x: 156, y: 54.42))
        bodyViewPath.addLine(to: CGPoint(x: 156, y: 323.57))
        bodyViewPath.addCurve(to: CGPoint(x: 152.73, y: 366.5), controlPoint1: CGPoint(x: 156, y: 345.58), controlPoint2: CGPoint(x: 156, y: 356.58))
        bodyViewPath.addLine(to: CGPoint(x: 152.25, y: 368.43))
        bodyViewPath.addCurve(to: CGPoint(x: 124.43, y: 396.25), controlPoint1: CGPoint(x: 147.55, y: 381.36), controlPoint2: CGPoint(x: 137.36, y: 391.55))
        bodyViewPath.addCurve(to: CGPoint(x: 79.57, y: 400), controlPoint1: CGPoint(x: 112.58, y: 400), controlPoint2: CGPoint(x: 101.58, y: 400))
        bodyViewPath.addLine(to: CGPoint(x: 76.43, y: 400))
        bodyViewPath.addCurve(to: CGPoint(x: 33.5, y: 396.73), controlPoint1: CGPoint(x: 54.42, y: 400), controlPoint2: CGPoint(x: 43.42, y: 400))
        bodyViewPath.addLine(to: CGPoint(x: 31.57, y: 396.25))
        bodyViewPath.addCurve(to: CGPoint(x: 3.75, y: 368.43), controlPoint1: CGPoint(x: 18.64, y: 391.55), controlPoint2: CGPoint(x: 8.45, y: 381.36))
        bodyViewPath.addCurve(to: CGPoint(x: 0, y: 323.57), controlPoint1: CGPoint(x: 0, y: 356.58), controlPoint2: CGPoint(x: 0, y: 345.58))
        bodyViewPath.addLine(to: CGPoint(x: 0, y: 76.43))
        bodyViewPath.addCurve(to: CGPoint(x: 3.27, y: 33.5), controlPoint1: CGPoint(x: 0, y: 54.42), controlPoint2: CGPoint(x: 0, y: 43.42))
        bodyViewPath.addLine(to: CGPoint(x: 3.75, y: 31.57))
        bodyViewPath.addCurve(to: CGPoint(x: 31.57, y: 3.75), controlPoint1: CGPoint(x: 8.45, y: 18.64), controlPoint2: CGPoint(x: 18.64, y: 8.45))
        bodyViewPath.addCurve(to: CGPoint(x: 76.43, y: 0), controlPoint1: CGPoint(x: 43.42, y: -0), controlPoint2: CGPoint(x: 54.42, y: 0))
        bodyViewPath.close()
        palette.sliderColor.setFill()
        bodyViewPath.fill()
        
        context.endTransparencyLayer()
        context.restoreGState()
        
        context.saveGState()
        context.setBlendMode(.multiply)
        context.restoreGState()
    
        context.endTransparencyLayer()
        context.restoreGState()
    }

    @objc(SectionedSliderResizingBehavior)
    public enum ResizingBehavior: Int {
        case aspectFit /// The content is proportionally resized to fit into the target rectangle.
        case aspectFill /// The content is proportionally resized to completely fill the target rectangle.
        case stretch /// The content is stretched to match the entire target rectangle.
        case center /// The content is centered in the target rectangle, but it is NOT resized.
        public func apply(rect: CGRect, target: CGRect) -> CGRect {
            if rect == target || target == CGRect.zero {
                return rect
            }

            var scales = CGSize.zero
            scales.width = abs(target.width / rect.width)
            scales.height = abs(target.height / rect.height)

            switch self {
                case .aspectFit:
                    scales.width = min(scales.width, scales.height)
                    scales.height = scales.width
                case .aspectFill:
                    scales.width = max(scales.width, scales.height)
                    scales.height = scales.width
                case .stretch:
                    break
                case .center:
                    scales.width = 1
                    scales.height = 1
            }

            var result = rect.standardized
            result.size.width *= scales.width
            result.size.height *= scales.height
            result.origin.x = target.minX + (target.width - result.width) / 2
            result.origin.y = target.minY + (target.height - result.height) / 2
            return result
        }
    }
}

class SectionedSliderLayer: CALayer {
    // MARK: - Properties
    @NSManaged var factor: CGFloat
    
    // MARK: - Initializers
    override init() {
        super.init()
        factor = 0
    }
    
    override init(layer: Any) {
        super.init(layer: layer)
        if let layer = layer as? SectionedSliderLayer {
            factor = layer.factor
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

internal class Flow {
    // MARK: - Functions
    // Execute code block asynchronously
    static func async(block: @escaping () -> Void) {
        DispatchQueue.main.async(execute: block)
    }
    
    // Execute code block asynchronously after given delay time
    static func delay(for delay: TimeInterval, block: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delay, execute: block)
    }
}

open class Palette {
    var viewBackgroundColor: UIColor = .black
    var sliderBackgroundColor: UIColor = UIColor(rgb: 0x252525)
    var sliderColor: UIColor = UIColor(rgb: 0x6701CE)
    
    public init(viewBackgroundColor: UIColor? = nil, sliderBackgroundColor: UIColor? = nil, sliderColor: UIColor? = nil) {
        self.viewBackgroundColor = viewBackgroundColor ?? self.viewBackgroundColor
        self.sliderBackgroundColor = sliderBackgroundColor ?? self.sliderBackgroundColor
        self.sliderColor = sliderColor ?? self.sliderColor
    }
}

@IBDesignable
open class CustomSlider: UIView {
    
    // MARK: - IBDesignable and IBInspectable
    var viewBackgroundColor: UIColor? {
        didSet {
            palette.viewBackgroundColor = viewBackgroundColor ?? palette.viewBackgroundColor
        }
    }
    
    var sliderBackgroundColor: UIColor? {
        didSet {
            palette.sliderBackgroundColor = sliderBackgroundColor ?? palette.sliderBackgroundColor
        }
    }
    
    var sliderColor: UIColor? {
        didSet {
            palette.sliderColor = sliderColor ?? palette.sliderColor
        }
    }
    
    open var sections: Int = 10 {
        willSet {
            if newValue < 2 || newValue > 20 {
                debugPrint("sections must be between 2 and 20")
            }
        }
    }

    open var selectedSection: Int = 0 {
        didSet {
            if selectedSection < 0 || selectedSection > sections {
                debugPrint("sections must be between 0 and \(sections)")
            } else {
                factor = CGFloat(selectedSection) / CGFloat(sections) - 0.0001
            }
        }
    }

    private var factor: CGFloat = 0.0 {
        willSet {
            (layer as? SectionedSliderLayer)?.factor = newValue
            delegate?.sectionChanged(slider: self, selected: abs(Int(ceil(CGFloat(newValue) * CGFloat(sections)))))
            draw()
        }
    }
    
    // MARK: - Properties
    private var keyPath: String = "factor"
    private var palette: Palette = Palette()
    open var delegate: SectionedSliderDelegate? {
        didSet {
            let factor = self.factor
            self.factor = factor
        }
    }
    
    override open class var layerClass: AnyClass {
        return SectionedSliderLayer.self
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public init(frame: CGRect, selectedSection: Int, sections: Int, palette: Palette = Palette()) {
        super.init(frame: frame)
        defer {
            self.backgroundColor = palette.viewBackgroundColor
            self.sections = sections
            self.selectedSection = selectedSection
            self.palette = palette
        }
        
        addPanGesture()
        draw()
        let image = UIImage(named: "light")
        
        let topImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 48, height: 48))
        topImageView.image = image
        addSubview(topImageView)
        topImageView.translatesAutoresizingMaskIntoConstraints = false
        topImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        topImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 15).isActive = true
        topImageView.widthAnchor.constraint(equalToConstant: 48).isActive = true
        topImageView.heightAnchor.constraint(equalToConstant: 48).isActive = true
        
        let bottomImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        bottomImageView.image = image
        addSubview(bottomImageView)
        bottomImageView.translatesAutoresizingMaskIntoConstraints = false
        bottomImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        bottomImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15).isActive = true
        bottomImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        bottomImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Lifecyle
    override open func awakeFromNib() {
        super.awakeFromNib()
        addPanGesture()
        draw()
    }
    
    override open func draw(_ layer: CALayer, in ctx: CGContext) {
        guard let layer: SectionedSliderLayer = layer as? SectionedSliderLayer else { return }
        let frame = CGRect(origin: CGPoint(x: 0, y: 0), size: layer.frame.size)
        UIGraphicsPushContext(ctx)
        
        switch keyPath {
        case "factor":
            StyleKit.drawSlider(frame: frame, factor: layer.factor, sections: CGFloat(sections), palette: palette)
            break
        default:
            break
        }
        
        UIGraphicsPopContext()
    }
    
    // MARK: - Functions
    
    private func addPanGesture() {
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(CustomSlider.dragged(gesture:)))
        self.addGestureRecognizer(gesture)
    }
    
    private func resetManipulables() {
        guard let layer: SectionedSliderLayer = layer as? SectionedSliderLayer else { return }
        layer.factor = 0.0
    }
    
    func draw() {
        needsDisplay()
    }
    
    func needsDisplay() {
        layer.contentsScale = UIScreen.main.scale
        layer.setNeedsDisplay()
    }

    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        guard
            let touch = touches.first
            else { return }

        var x = self.frame.height - touch.location(in: self).y
        x = x < 0 ? -1 : (x > self.frame.height ? self.frame.height : x)

        factor = x / self.frame.height
    }
    
    @objc private func dragged(gesture: UIPanGestureRecognizer) {
        let point = gesture.location(in: self)
        var x = self.frame.height - point.y
        x = x < 0 ? -1 : (x > self.frame.height ? self.frame.height : x)
        factor = x / self.frame.height
    }
    
}
