//
//  UIViewController+Toast.swift
//  steeloreel
//
//  Created by Jessica Yao on 4/1/18.
//  Copyright © 2018 Jessica Yao. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showToast(message : String) {
        
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 110, y: (self.view.window?.safeAreaInsets.top)! + 30, width: 220, height: 35))
        // self.view.frame.size.height
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
        //toastLabel.font = UIFont(name: "IranSansMobile", size: 12)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.01, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    } }
