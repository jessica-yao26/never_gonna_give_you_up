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
    
    static func setupView(view: UIView) {
        // Change and lock orientation to portrait
        lockOrientation(.landscape, andRotateTo: .portrait)
        lockOrientation(.portrait)
        // Set and scale background image
        let image = scaleUIImageToSize(image: UIImage(named: "pattern")!, size: CGSize(width: 175, height: 175))
        view.backgroundColor = UIColor(patternImage: image)
    }
}
