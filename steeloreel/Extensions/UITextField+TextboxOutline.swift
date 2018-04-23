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

    func setTextboxOutlineDarkGrey() {
        self.layer.backgroundColor = UIColor.groupTableViewBackground.cgColor
        self.layer.borderColor = UIColor.darkGray.cgColor
        self.layer.borderWidth = 1.0;
        self.layer.cornerRadius = 5;
    }
}
