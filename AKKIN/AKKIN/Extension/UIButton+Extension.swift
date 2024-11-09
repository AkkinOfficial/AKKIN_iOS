//
//  UIButton+Extension.swift
//  AKKIN
//
//  Created by 박지윤 on 8/15/24.
//

import UIKit

extension UIButton {
    func setUnderline() {
        guard let title = title(for: .normal) else { return }

        let attributedString = NSMutableAttributedString(string: title)
        attributedString.addAttribute(.underlineStyle,
                                      value: NSUnderlineStyle.single.rawValue,
                                      range: NSRange(location: 0, length: title.count)
        )
        setAttributedTitle(attributedString, for: .normal)
    }

    func setGuideButton(_ inputTitle: String) {
        setTitle(inputTitle, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        setTitleColor(.white, for: .normal)
        backgroundColor = .akkinGreen
        layer.cornerRadius = 12
    }

    func setBackButton() {
        isEnabled = true
        setImage(AkkinButton.backButton, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        backgroundColor = .clear
    }

    func setAlarmButton() {
        isEnabled = true
        setImage(AkkinButton.alarmButton, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        backgroundColor = .clear
    }

    func setLogo() {
        setImage(AkkinIcon.logo, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        backgroundColor = .clear
    }

    func setKebbab() {
        isEnabled = true
        setImage(AkkinButton.kebabButton, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        backgroundColor = .clear
    }

    func setCompleteButton(inputTitle: String) {
        setTitle(inputTitle, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        setTitleColor(.white, for: .normal)
        layer.cornerRadius = 0
    }
}
