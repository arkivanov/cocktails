
import UIKit

class SegmentControl: UISegmentedControl {
    // Can't be zero or size will error when click segment
    private let segmentInset: CGFloat = 0.1
    
    override init(items: [Any]?) {
        super.init(items: items)
        themeProvider.register(observer: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        clipOval()
        
        if #available(iOS 13.0, *) {
            removeTinting()
        }
        
        if let selectedImageView = subviews[numberOfSegments] as? UIImageView {
            selectedImageView.image = nil
            selectedImageView.bounds = selectedImageView.bounds.insetBy(dx: segmentInset, dy: segmentInset)
            selectedImageView.backgroundColor = themeProvider.theme.colors.primary
            selectedImageView.clipOval()
            selectedImageView.layer.removeAnimation(forKey: "SelectionBounds")
        }
    }
    
    private func removeTinting() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            for index in 0 ... (self.numberOfSegments - 1)  {
                let backgroundSegmentView = self.subviews[index]
                backgroundSegmentView.isHidden = true
            }
        }
    }
}

extension SegmentControl: Themeable {
    func apply(theme: any Theme) {
        backgroundColor = theme.colors.surface
        layer.borderColor = theme.colors.surface.cgColor
        setTitleTextAttributes([.foregroundColor: theme.colors.onSurface], for: .normal)
        setTitleTextAttributes([.foregroundColor: theme.colors.onPrimary], for: .selected)
    }
}
