//
//  BaseUITextField.swift
//  AKKIN
//
//  Created by 성현주 on 8/16/24.
//

import UIKit

final class BaseUITextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {
        self.backgroundColor = .akkinGray6
        self.addLeftPadding(width: 13)
        self.setRoundBorder()
        self.autocapitalizationType = .none
        self.clearButtonMode = .always
    }
}
