//
//  String+Extension.swift
//  AKKIN
//
//  Created by 박지윤 on 2024/01/09.
//

import Foundation
import UIKit

extension String {
    var toSaveContent: String {
        return "[ " + self + " ]"
    }

    var toMoney: String {
        return "무려 " + self + " 원"
    }

    func setLineSpacing(_ spacing: CGFloat) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = spacing

        let attrString = NSMutableAttributedString(string: self)
        attrString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attrString.length))

        return attrString
    }
}
