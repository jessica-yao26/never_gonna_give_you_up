//
//  PassThroughToWindowView.swift
//  steeloreel
//
//  Created by Jessica Yao on 4/15/18.
//  Copyright © 2018 Jessica Yao. All rights reserved.
//

import Foundation
import UIKit
class PassThroughView: UIView {
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        for subview in subviews {
            if !subview.isHidden && subview.isUserInteractionEnabled && subview.point(inside: convert(point, to: subview), with: event) {
                return true
            }
        }
        return false
    }
}
