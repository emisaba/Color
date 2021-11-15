import UIKit
import AVFoundation
import ChameleonFramework

class BeforeShootingViewController: UIViewController {
    
    // MARK: - properties
    
    public let imageWidth = Dimension.imageWidth
    public let imageHeight = Dimension.imageHeight
    public var topBlackSpaceHeight = Dimension.topBlackSpaceHeight
    public var buttonHeight = Dimension.startShootingButtonHeight
    
    public let unableTapTopBlackArea = UIButton()
    public let unableTapBottomBlackArea = UIButton()
    
    public var modifiedImage = UIImage()
    public let filteredImageView = UIImageView()
    
    public let cameraView = CameraView()
    
    public lazy var shootingButton: UIButton = {
        let buttonWidth: CGFloat = 50
        let button = UIButton(type: .system)
        button.setTitle("撮影開始", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = buttonWidth / 2
        button.backgroundColor = .gray
        button.addTarget(self, action: #selector(onClickShootingButton(sender:)), for: .touchUpInside)
        return button
    }()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        
        setupPinchGesture()
        setupUI()
    }
    
    // MARK: - Helpers
    
    func setupUI() {
        view.addSubview(cameraView)
        cameraView.frame = view.frame
        
        self.shootingButton.frame = CGRect(x: 0,
                                           y: 0,
                                           width: 100,
                                           height: buttonHeight)
        self.shootingButton.center.x = view.frame.width / 2
        self.shootingButton.center.y = view.frame.height - topBlackSpaceHeight / 2
        self.view.addSubview(shootingButton)
    }
    
    // MARK: - Actions
    
    @objc func onClickShootingButton(sender: UIButton) {
        self.shootingButton.removeFromSuperview()
    }
}
