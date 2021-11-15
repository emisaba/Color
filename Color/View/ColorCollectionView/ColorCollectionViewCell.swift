import UIKit

class ColorCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    var viewModal: ColorViewModal? {
        didSet { configureUI() }
    }
    
    private let colorView = UIView()
    private let colorLabel = UILabel()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(colorView)
        colorView.frame = bounds
        
        addSubview(colorLabel)
        colorLabel.frame = bounds
        colorLabel.backgroundColor = .clear
        
        let angle = 90 * CGFloat.pi / 180
        let transrotate = CGAffineTransform(rotationAngle: angle)
        colorLabel.transform = transrotate
        colorLabel.textAlignment = .center
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        guard let viewModal = viewModal else { return }
        
        colorView.backgroundColor = viewModal.backgroundColor
        colorLabel.text = "# \(viewModal.colorLabelText)"
        colorLabel.textColor = viewModal.colorLabelTextColor
    }
}
