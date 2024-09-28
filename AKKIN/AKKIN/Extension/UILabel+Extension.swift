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

    func setLineSpacing(_ lineSpacing: CGFloat) {
        guard let text = self.text else { return }

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing

        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedString.length))

        self.attributedText = attributedString
    }

    func setRangeAttributedText(title: String, highlightedText: String, highlightedColor: UIColor, highlightedFont: UIFont) {
        let fullText = title 
        let attributedString = NSMutableAttributedString(string: fullText)

        let range = (fullText as NSString).range(of: highlightedText)
        attributedString.addAttribute(.foregroundColor, value: highlightedColor, range: range)
        attributedString.addAttribute(.font, value: highlightedFont, range: range)

        self.attributedText = attributedString
    }
}
