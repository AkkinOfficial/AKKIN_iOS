//
//  BaseUITextField.swift
//  AKKIN
//
//  Created by 성현주 on 9/2/24.
//

import UIKit

final class BaseTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {
        let placeholderText = "이곳에 입력하세요"
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.akkinGray6, // 원하는 색상
            .font: UIFont.systemFont(ofSize: 17) // 원하는 폰트
        ]
        self.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: attributes)

        self.backgroundColor = .akkinTextFieldBackGround
        self.setRoundBorder()
        self.autocapitalizationType = .none
        self.clearButtonMode = .always
    }
}
