//
//  UIColorExtension.swift
//  SignUpFlow
//
//  Created by Wonhee on 2020/12/02.
//

import Foundation
import UIKit

extension UIColor {
    static var textViewTextColor: UIColor {
        if #available(iOS 13, *) {
            return UIColor { (traitCollection: UITraitCollection) -> UIColor in
                if traitCollection.userInterfaceStyle == .dark {
                    return UIColor.white
                } else {
                    return UIColor.black
                }
            }
        } else {
            return UIColor.black
        }
    }
}
