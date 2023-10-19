//
//  CustomActivityIndicatorView.swift
//  WeatherApp
//
//  Created by rguttula on 13/03/21.
//

import UIKit
import QuartzCore

class CustomActivityIndicatorView: UIView {
    
    // MARK: - Properties

    lazy fileprivate var animationLayer : CALayer = {
        return CALayer()
    }()
    
    var isAnimating : Bool = false
    var hidesWhenStopped : Bool = true
    
    // MARK: - init

    init(image : UIImage) {
        
        super.init(frame: CGRect(x: 0, y: 0, width: Constants.LOADING_INDECATOR_HEIGHT, height: Constants.LOADING_INDECATOR_HEIGHT))
        let frame : CGRect = CGRect(x: (Constants.LOADING_INDECATOR_HEIGHT - image.size.width)/2, y: (Constants.LOADING_INDECATOR_HEIGHT - image.size.height)/2, width: image.size.width, height: image.size.height)
        
        animationLayer.frame = frame
        animationLayer.contents = image.cgImage
        animationLayer.masksToBounds = true
       // self.backgroundColor = Constants.GreenthemeColor
        self.backgroundColor = .lightGray

        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        // drop shadow
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 3.0
        self.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        self.layer.addSublayer(animationLayer)
        
        addRotation(forLayer: animationLayer)
        pause(animationLayer)
        self.isHidden = true
    }

    // MARK: - init

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - addRotation

    func addRotation(forLayer layer : CALayer) {
        let rotation : CABasicAnimation = CABasicAnimation(keyPath:"transform.rotation.z")
        
        rotation.duration = 1.0
        rotation.isRemovedOnCompletion = false
        rotation.repeatCount = HUGE
        
        rotation.fillMode = CAMediaTimingFillMode.forwards
        //rotation.fillMode = CAMediaTimingFillMode.forwards
        rotation.fromValue = NSNumber(value: 0.0 as Float)
        rotation.toValue = NSNumber(value: 3.14 * 2.0 as Float)
        
        layer.add(rotation, forKey: "rotate")
    }

    // MARK: - pause

    func pause(_ layer : CALayer) {
        let pausedTime = layer.convertTime(CACurrentMediaTime(), from: nil)
        
        layer.speed = 0.0
        layer.timeOffset = pausedTime
        
        isAnimating = false
    }

    // MARK: - resume

    func resume(_ layer : CALayer) {
        let pausedTime : CFTimeInterval = layer.timeOffset
        
        layer.speed = 1.0
        layer.timeOffset = 0.0
        layer.beginTime = 0.0
        
        let timeSincePause = layer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        layer.beginTime = timeSincePause
        
        isAnimating = true
    }

    // MARK: - startAnimating

    func startAnimating () {
        
        if isAnimating {
            return
        }
        
        if hidesWhenStopped {
            self.isHidden = false
        }
        resume(animationLayer)
    }

    // MARK: - stopAnimating

    func stopAnimating () {
        if hidesWhenStopped {
            self.isHidden = true
        }
        pause(animationLayer)
    }
}
