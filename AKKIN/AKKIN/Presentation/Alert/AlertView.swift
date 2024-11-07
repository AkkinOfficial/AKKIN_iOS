//
//  PopUpView.swift
//  AKKIN
//
//  Created by 성현주 on 11/8/24.
//

import UIKit
import SnapKit

final class AlertView: BaseView {

     lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        return view
    }()

     lazy var containerStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 12.0
        view.alignment = .center
        return view
    }()

    lazy var buttonStackView: UIStackView = {
        let view = UIStackView()
        view.spacing = 14.0
        view.distribution = .fillEqually
        return view
    }()

    private lazy var titleLabel: UILabel? = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18.0, weight: .bold)
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()

    private lazy var messageLabel: UILabel? = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16.0)
        label.textColor = .gray
        label.numberOfLines = 0
        return label
    }()

    lazy var confirmButton: BaseButton = {
        let button = BaseButton()
        button.setTitle("확인", for: .normal)
        button.isEnabled = true
        return button
    }()

    lazy var latterButton: BaseButton = {
        let button = BaseButton()
        button.setTitle("나중에", for: .normal)
        button.isEnabled = true
        return button
    }()

    // MARK: Properties
    var tapConfirm: (() -> Void)?


    override func configureSubviews() {

        addSubview(containerView)
        containerView.addSubview(containerStackView)
        buttonStackView.addArrangedSubviews(confirmButton,latterButton)

        if let titleLabel = titleLabel {
            containerStackView.addArrangedSubview(titleLabel)
        }

        if let messageLabel = messageLabel {
            containerStackView.addArrangedSubview(messageLabel)
        }

        if let lastView = containerStackView.subviews.last {
            containerStackView.setCustomSpacing(24.0, after: lastView)
        }

        containerStackView.addArrangedSubview(buttonStackView)

        confirmButton.addTarget(self, action: #selector(didTapConfirmButton), for: .touchUpInside)
    }

    override func makeConstraints() {
        containerView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(26)
            make.top.greaterThanOrEqualToSuperview().inset(32)
            make.bottom.lessThanOrEqualToSuperview().inset(32)
        }

        containerStackView.snp.makeConstraints { make in
            make.edges.equalTo(containerView).inset(24)
        }

        buttonStackView.snp.makeConstraints { make in
            make.height.equalTo(48)
            make.width.equalTo(containerStackView)
        }
    }

    // MARK: Event
    @objc private func didTapConfirmButton() {
        tapConfirm?()
    }
}
