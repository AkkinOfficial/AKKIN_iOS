//
//  BaseButton.swift
//  AKKIN
//
//  Created by MK-Mac-413 on 2023/09/04.
//

import UIKit

class BaseButton: UIButton {

    override var isEnabled: Bool {
        didSet {
            isEnabled ? setEnableButton() : setDisableButton()
        }
    }

    // MARK: Properties
    var tap: (() -> Void)?

    // MARK: Initializer
    init() {
        super.init(frame: .zero)
        configureTap()
        setBaseButton()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Configuration
    private func configureTap() {
        addTarget(self, action: #selector(handleEvent), for: .touchUpInside)
    }

    func setBaseButton() {
        self.backgroundColor = .akkinGreen
        self.layer.cornerRadius = 16
        self.isEnabled = false
    }

    func setEnableButton() {
        isUserInteractionEnabled = true
        backgroundColor = .akkinGreen
    }

    func setDisableButton() {
        isUserInteractionEnabled = false
        backgroundColor = .akkinGreen.withAlphaComponent(0.6)
    }

    // MARK: Event
    @objc private func handleEvent() {
        tap?()
    }
}
