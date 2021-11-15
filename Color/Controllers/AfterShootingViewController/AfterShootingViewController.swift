import UIKit
import AVFoundation
import ChameleonFramework

class AfterShootingViewController: BeforeShootingViewController {
    
    // MARK: - Properties
    
    private var shouldStartSession = false
    
    // Filter image
    public var sourceImage: CIImage?
    private var FilterCIImage = CIImage()
    
    public var huefilter = CIFilter()
    public var saturationFilter = CIFilter()
    public var brightnessFilter = CIFilter()
    
    
    // Slider
    public let sliderBaseView = UIView()
    
    public var hueSlider = UISlider()
    public var saturationSlider = UISlider()
    public var brightnessSlider = UISlider()
    
    public var hueSliderValue: Float = 0.0
    public var saturationSliderValue: Float = 1.0
    public var brightnessSliderValue: Float = 0.0
    
    public lazy var hueChangeValue = createSliderValueLabel(positionY: 0)
    public lazy var SaturationChangeValue = createSliderValueLabel(positionY: 50)
    public lazy var brightnessChangeValue = createSliderValueLabel(positionY: 100)
    
    public var hueValueForLabel: Int = 0
    public var saturationValueForLabel: Int = 0
    public var brightnessValueForLabel: Int = 0
    
    
    // Color
    public var colors = [UIColor]()
    public var colorDic: [UIColor: Int] = [:]
    public var showColorInfoImage = UIImage()
    
    private let colorCollectionView = ColorCollectionView()
    
    public lazy var topColors: [UIColor] = [] {
        didSet {
            colorCollectionView.colors = topColors
            colorCollectionView.collectionView.reloadData()
        }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        huefilter = CIFilter(name: "CIHueAdjust")!
        saturationFilter = CIFilter(name: "CIColorControls")!
        brightnessFilter = CIFilter(name: "CIExposureAdjust")!
    }
    
    // MARK: - Actions
    
    @objc override func onClickShootingButton(sender: UIButton) {
            
        if !shouldStartSession {
            stopSession()
            prepareForNextShooting()
            shouldStartSession = true
        } else {
            startSession()
            shouldStartSession = false
        }
    }
    
    // MARK: - Helpers
    
    func prepareForNextShooting() {
        
        cameraView.captureSession.stopRunning()
        
        self.shootingButton.setTitle("撮影", for: .normal)
        
        self.hueValueForLabel = 0
        self.saturationValueForLabel = 0
        self.brightnessValueForLabel = 0
        
        self.hueSliderValue = 0.0
        self.saturationSliderValue = 1.0
        self.brightnessSliderValue = 0.0
        
        setupSlider()
        
        view.addSubview(colorCollectionView)
        colorCollectionView.frame = CGRect(x: 0,
                                           y: 0,
                                           width: view.frame.width,
                                           height: topBlackSpaceHeight)
    }
    
    func startSession() {
        sliderBaseView.removeFromSuperview()
        hueSlider.removeFromSuperview()
        saturationSlider.removeFromSuperview()
        brightnessSlider.removeFromSuperview()
        colorCollectionView.removeFromSuperview()
        filteredImageView.removeFromSuperview()
        
        cameraView.captureSession.startRunning()
    }
    
    func stopSession() {
        guard let previewImage = cameraView.previewImageView.image else { return }
        showColorInfo(previewImage: previewImage)
        createFilterdImage()
    }
    
    func showColorInfo(previewImage: UIImage) {
        self.modifiedImage = UIImage.modifyImageDirection(image: previewImage,
                                                          width: previewImage.size.width,
                                                          height: previewImage.size.height,
                                                          blendemode: CGBlendMode.screen)
        
        setupFilteredImageView()
        showColorInfo(image: self.filteredImageView.image!, valueChanged: false)
    }
    
    func setupFilteredImageView() {
        self.filteredImageView.frame = CGRect(x: 0,
                                                y: 0,
                                                width: view.frame.width,
                                                height: view.frame.height)
        self.filteredImageView.center = self.view.center
        self.filteredImageView.image = self.modifiedImage
        self.filteredImageView.contentMode = .scaleAspectFit
        self.view.bringSubviewToFront(self.filteredImageView)
        self.view.addSubview(self.filteredImageView)
    }
    
    func createFilterdImage() {
        guard let originalImage = filteredImageView.image else { return }
        FilterCIImage = CIImage(image: originalImage)!
        self.sourceImage = FilterCIImage
    }
}
