//
//  Utilites.swift
//  WeatherApp
//
//  Created by rguttula on 12/03/21.
//

import Foundation
import UIKit

class Utilities: NSObject {
    
    
    static fileprivate var activityIndicator : CustomActivityIndicatorView = {
        let image : UIImage = UIImage(named: "loading")!
        return CustomActivityIndicatorView(image: image)
    }()
    
    // MARK: - startLoadingIndecator
    
    class func startLoadingIndecator(_ onView : UIView) {
        onView.isUserInteractionEnabled = false
        onView.addSubview(activityIndicator)
        activityIndicator.center = onView.center
        activityIndicator.startAnimating()
    }
    
    // MARK: - stopLoadingIndecator
    
    class func stopLoadingIndecator(_ onView : UIView) {
        

        onView.isUserInteractionEnabled = true
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
    }
}
extension Dictionary
{
    func getStringValue(key: String)-> String{
        var responseVal = ""
        if let dictionaryRef : [String:AnyObject] = self as? [String:AnyObject]
        {
            if let tempValue = dictionaryRef[key] as? String
            {
                responseVal = tempValue
            }
        }
        return responseVal
    }
    
}

extension UIViewController {
    func displayAlert(titleStr: String?, messageStr: String?) {
        let alert = UIAlertController(title: titleStr, message: messageStr, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (_) -> Void in
        }))
        self.present(alert, animated: true, completion: nil)
    }
}

