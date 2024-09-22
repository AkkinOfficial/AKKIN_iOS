//
//  UILabel+Extension.swift
//  AKKIN
//
//  Created by 박지윤 on 9/23/24.
//

import UIKit

extension UILabel {
    func setColor(targetString: String, color: UIColor) {
        let fullText = text ?? ""
        let attributedString = NSMutableAttributedString(string: fullText)
        let range = (fullText as NSString).range(of: targetString)
        attributedString.addAttribute(.foregroundColor, value: color, range: range)
        attributedText = attributedString
    }
}
