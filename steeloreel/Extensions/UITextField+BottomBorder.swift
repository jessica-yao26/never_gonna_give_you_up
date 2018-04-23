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
        self.layer.borderWidth = 1.0;
        self.layer.cornerRadius = 5;
    }
}
