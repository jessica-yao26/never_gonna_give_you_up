//
//  AppUtility.swift
//  steeloreel
//
//  Created by Jessica Yao on 3/28/18.
//  Copyright © 2018 Jessica Yao. All rights reserved.
//

import Foundation
import UIKit

struct AppUtility {
    
    static let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    static let usernameRegex = "[A-Za-z0-9._]{1,64}"
    static let nameRegex = "[A-Za-z'’.-]{1,64}"
    
    static func lockOrientation(_ orientation: UIInterfaceOrientationMask) {
        
        if let delegate = UIApplication.shared.delegate as? AppDelegate {
            delegate.orientationLock = orientation
        }
    }
    
    /// OPTIONAL Added method to adjust lock and rotate to the desired orientation
    static func lockOrientation(_ orientation: UIInterfaceOrientationMask, andRotateTo rotateOrientation:UIInterfaceOrientation) {
        
        self.lockOrientation(orientation)
        
        UIDevice.current.setValue(rotateOrientation.rawValue, forKey: "orientation")
    }
    
    static func scaleUIImageToSize(image: UIImage, size: CGSize) -> UIImage {
        let hasAlpha = false
        let scale: CGFloat = 0.0 // Automatically use scale factor of main screen
        
        UIGraphicsBeginImageContextWithOptions(size, !hasAlpha, scale)
        image.draw(in: CGRect(origin: CGPoint(x: 0,y :0), size: size))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return scaledImage!
    }
    
    // Helpers composed of utility methods
    
    static func setupLandingView(view: UIView) {
        // Change and lock orientation to portrait
        lockOrientation(.landscape, andRotateTo: .portrait)
        lockOrientation(.portrait)
        // Set and scale background image
        let image = scaleUIImageToSize(image: UIImage(named: "pattern")!, size: CGSize(width: 175, height: 175))
        view.backgroundColor = UIColor(patternImage: image)
    }
    
    static func setupView(view: UIView) {
        // Change and lock orientation to portrait
        lockOrientation(.landscape, andRotateTo: .portrait)
        lockOrientation(.portrait)
    }
    
    static func setArrowButtonImages(backButton: UIButton, forwardButton: UIButton) {
        let backImage = UIImage(named: "left-arrow")
        let forwardImage = UIImage(named: "right-arrow")
        backButton.setBackgroundImage(backImage, for: .normal)
        forwardButton.setBackgroundImage(forwardImage, for: .normal)
    }
    
    static func SegueFromRightViewControllerHelper(sourceViewController: UIViewController, destinationViewController: UIViewController) {
            let src = sourceViewController
            let dst = destinationViewController
            
            src.view.superview?.insertSubview(dst.view, aboveSubview: src.view)
            dst.view.transform = CGAffineTransform(translationX: src.view.frame.size.width, y: 0)
            
            UIView.animate(withDuration: 0.25,
                           delay: 0.0,
                           options: .curveEaseInOut,
                           animations: {
                            dst.view.transform = CGAffineTransform(translationX: 0, y: 0)
            },
                           completion: { finished in
                            src.present(dst, animated: false, completion: nil)
            }
            )
    }
    
    static func clearLoginSignUpUserDefaults() {
        UserDefaults.standard.removeObject(forKey: "email")
        UserDefaults.standard.removeObject(forKey: "first_name")
        UserDefaults.standard.removeObject(forKey: "last_name")
    }
    
    static func isValid(testStr: String, regex: String) -> Bool {
        let test = NSPredicate(format:"SELF MATCHES %@", regex)
        
        return test.evaluate(with: testStr)
    }
}
