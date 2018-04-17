//
//  UITextField+BottomBorder.swift
//  steeloreel
//
//  Created by Jessica Yao on 4/8/18.
//  Copyright © 2018 Jessica Yao. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    func setBottomBorder() {
        self.borderStyle = .none
        self.layer.backgroundColor = UIColor.white.cgColor
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
    func setTextboxOutlineDarkGrey() {
        self.layer.backgroundColor = UIColor.groupTableViewBackground.cgColor
        self.layer.borderColor = UIColor.darkGray.cgColor
        self.layer.borderWidth = 0.5
        self.layer.cornerRadius = 5;
    }
    func setTextboxOutlineDarkGreyExceptBottom() {
        self.layer.cornerRadius = 5;
        let borderTop = CALayer()
        let borderLeft = CALayer()
        let borderRight = CALayer()
        borderTop.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: 0.5)
        borderLeft.frame = CGRect(x:0, y:0, width: 0.5, height: self.frame.size.height)
        borderRight.frame = CGRect(x:self.frame.size.width - 0.5, y: 0, width: 0.5, height:self.frame.size.height)
        borderTop.backgroundColor = UIColor.darkGray.cgColor
        borderLeft.backgroundColor = UIColor.darkGray.cgColor
        borderRight.backgroundColor = UIColor.darkGray.cgColor
        
        self.layer.backgroundColor = UIColor.groupTableViewBackground.cgColor
        
        self.layer.addSublayer(borderTop)
        self.layer.addSublayer(borderLeft)
        self.layer.addSublayer(borderRight)
    }
}
