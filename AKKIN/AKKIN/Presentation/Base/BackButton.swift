//
//  BackButton.swift
//  AKKIN
//
//  Created by 신종원 on 9/14/24.
//

import UIKit

class BackButton: UIButton {

    // MARK: Properties
    var tapBack: (() -> Void)?

    // MARK: Initializer
    init() {
        super.init(frame: .zero)
        configureTap()
        setBackButton()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Configuration
    private func configureTap() {
        addTarget(self, action: #selector(handleEvent), for: .touchUpInside)
    }

    func setBackButton() {
        self.isEnabled = true
        self.setImage(AkkinButton.backButton, for: .normal)
        self.isUserInteractionEnabled = true
    }

    // MARK: Event
    @objc private func handleEvent() {
        tapBack?()
    }
}
