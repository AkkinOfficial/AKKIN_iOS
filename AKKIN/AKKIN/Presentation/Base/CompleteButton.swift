//
//  BackButton.swift
//  AKKIN
//
//  Created by 신종원 on 9/15/24.
//

import UIKit

class CompleteButton: UIButton {

    override var isEnabled: Bool {
        didSet {
            isEnabled ? setEnableButton() : setDisableButton()
        }
    }

    // MARK: Properties
    var tapComplete: (() -> Void)?

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
        self.isEnabled = false
        self.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
    }

    func setEnableButton() {
        isUserInteractionEnabled = true
        backgroundColor = .akkinGreen
        setTitleColor(.white, for: .normal)
    }

    func setDisableButton() {
        isUserInteractionEnabled = false
        backgroundColor = .akkinGreen.withAlphaComponent(0.6)
        tintColor = .white.withAlphaComponent(0.6)
    }

    // MARK: Event
    @objc private func handleEvent() {
        tapComplete?()
    }
}
