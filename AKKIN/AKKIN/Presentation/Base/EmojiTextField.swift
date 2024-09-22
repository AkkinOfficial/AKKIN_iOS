//
//  EmojiTextField.swift
//  AKKIN
//
//  Created by 신종원 on 9/2/24.
//

import UIKit

final class EmojiTextField: UITextField {

    override var textInputMode: UITextInputMode? {
        .activeInputModes.first(where: { $0.primaryLanguage == "emoji" })
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
