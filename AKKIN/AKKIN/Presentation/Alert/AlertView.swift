//
//  PopUpView.swift
//  AKKIN
//
//  Created by 성현주 on 11/8/24.
//

import UIKit
import SnapKit

final class AlertView: BaseView {

    private let alertType: AlertType

       init(alertType: AlertType) {
           self.alertType = alertType
           super.init(frame: .zero)
       }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

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

     lazy var emojiLabel: UILabel? = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 40.0, weight: .bold)
        return label
    }()

     lazy var textLabel: UILabel? = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20.0)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()

    lazy var rightButton: BaseButton = {
        let button = BaseButton()
        button.setTitle("확인", for: .normal)
        button.isEnabled = true
        return button
    }()

    lazy var leftButton: BaseButton = {
        let button = BaseButton()
        button.setTitle("나중에", for: .normal)
        button.isEnabled = true
        button.setLatterButton()
        return button
    }()

    // MARK: Properties
    var tapLeftButton: (() -> Void)?
    var tapRightButton: (() -> Void)?


    override func configureSubviews() {

        addSubview(containerView)
        containerView.addSubview(containerStackView)

        if alertType == .piggyBankNonExistence {
            buttonStackView.addArrangedSubview(leftButton)
            leftButton.setTitle("나중에", for: .normal)
            rightButton.setTitle("만들기", for: .normal)
            buttonStackView.addArrangedSubview(rightButton)
        } else {
            buttonStackView.addArrangedSubview(rightButton)
        }

        if let emojiLabel = emojiLabel {
            containerStackView.addArrangedSubview(emojiLabel)
        }

        if let textLabel = textLabel {
            containerStackView.addArrangedSubview(textLabel)
        }

        containerStackView.addArrangedSubview(buttonStackView)

        leftButton.addTarget(self, action: #selector(didTapLeftButton), for: .touchUpInside)
        rightButton.addTarget(self, action: #selector(didTapRightButton), for: .touchUpInside)
    }

    override func makeConstraints() {
        containerView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(40)
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
    @objc private func didTapLeftButton() {
        tapLeftButton?()
    }

    @objc private func didTapRightButton() {
        tapRightButton?()
    }
}
