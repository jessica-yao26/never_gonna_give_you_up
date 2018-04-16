//
//  UIButton+moveImageLeftTextCenter.swift
//  steeloreel
//
//  Created by Jessica Yao on 4/16/18.
//  Copyright © 2018 Jessica Yao. All rights reserved.
//

import Foundation
import UIKit
extension UIButton {
    func moveImageLeftTextCenter(imagePadding: CGFloat = 10.0){
        guard let imageViewWidth = self.imageView?.frame.width else{return}
        guard let titleLabelWidth = self.titleLabel?.intrinsicContentSize.width else{return}
        self.contentHorizontalAlignment = .left
        imageEdgeInsets = UIEdgeInsets(top: 0.0, left: imagePadding - imageViewWidth / 1.75, bottom: 0.0, right: 0.0)
        titleEdgeInsets = UIEdgeInsets(top: 0.0, left: bounds.width / 2 - imageViewWidth - titleLabelWidth / 2, bottom: 0.0, right: titleLabelWidth)
    }
}
