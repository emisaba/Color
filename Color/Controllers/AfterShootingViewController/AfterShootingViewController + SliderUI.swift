import UIKit

extension AfterShootingViewController {
    
    func createSlider(y: CGFloat, value: Float, minValue: Float, maxValue: Float, imageName: String) {
        let slider = UISlider(frame: CGRect(x: 75,
                                            y: y,
                                            width: view.frame.size.width -  95,
                                            height: 80))
        slider.minimumTrackTintColor = .darkGray
        slider.value = value
        slider.minimumValue = minValue
        slider.maximumValue = maxValue
        slider.minimumTrackTintColor = .init(white: 0.4, alpha: 1)
        slider.maximumTrackTintColor = .init(white: 0.5, alpha: 1)
        slider.setThumbImage(UIImage(named: imageName)!.resizableImage(withCapInsets: .zero, resizingMode: .tile), for: .normal)
        slider.addTarget(self, action: #selector(didFinishTouching(sender:)), for: .touchUpInside)
        
        switch imageName {
        case "hue":
            slider.addTarget(self, action: #selector(hueSliderChanged(sender:)), for: .valueChanged)
        case "saturation":
            slider.addTarget(self, action: #selector(saturationSliderChanged(sender:)), for: .valueChanged)
        case "brightness":
            slider.addTarget(self, action: #selector(brightnessSliderChanged(sender:)), for: .valueChanged)
        default:
            break
        }
        
        sliderBaseView.addSubview(slider)
    }
    
    func createSliderValueLabel(positionY: CGFloat) -> UILabel {
        let label = UILabel()
        label.frame = CGRect(x: 20, y: positionY, width: 50, height: 80)
        label.textColor = .white
        return label
    }
    
    func setupSlider() {
        
        sliderBaseView.frame =  CGRect(x: 0,
                                       y: view.frame.height - topBlackSpaceHeight * 2 + 12,
                                       width: view.frame.width, height: topBlackSpaceHeight)
        sliderBaseView.backgroundColor = UIColor.init(white: 0, alpha: 0.5)
        self.view.addSubview(sliderBaseView)
        
        createSlider(y: 0, value: 0, minValue: -0.1, maxValue: 0.1, imageName: "hue")
        
        hueChangeValue.text = "   \(hueValueForLabel)"
        sliderBaseView.addSubview(hueChangeValue)
        
        createSlider(y: 50, value: 1, minValue: 0, maxValue: 2, imageName: "saturation")
        
        SaturationChangeValue.text = "   \(saturationValueForLabel)"
        sliderBaseView.addSubview(SaturationChangeValue)
        
        createSlider(y: 100, value: 0, minValue: -1, maxValue: 1, imageName: "brightness")
        
        brightnessChangeValue.text = "   \(brightnessValueForLabel)"
        sliderBaseView.addSubview(brightnessChangeValue)
    }
}
