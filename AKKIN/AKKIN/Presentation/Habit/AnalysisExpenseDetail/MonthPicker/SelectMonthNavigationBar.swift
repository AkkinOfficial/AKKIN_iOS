//
//  SelectMonthNavigationBar.swift
//  AKKIN
//
//  Created by 박지윤 on 8/28/24.
//

import UIKit

final class SelectMonthNavigationBar: BaseView {

    // MARK: UI Components
    private let navigationTitleLabel = UILabel().then {
        $0.text = "월 선택하기"
        $0.textColor = .akkinBlack
        $0.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
    }

    let dismissButton = BaseButton().then {
        $0.setImage(AkkinButton.closeButton, for: .normal)
    }

    private let dividerView = UIView().then {
        $0.backgroundColor = .akkinGray7
        $0.alpha = 0.5
    }

    // MARK: Properties
    var tapDismissButton: (() -> Void)?

    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()

        addSubview(navigationTitleLabel)
        addSubview(dismissButton)
        addSubview(dividerView)

        dismissButton.addTarget(self, action: #selector(handleDismissButtonEvent), for: .touchUpInside)
    }

    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()

        snp.makeConstraints {
            $0.height.equalTo(62)
        }

        navigationTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(21)
            $0.centerX.equalToSuperview()
        }

        dismissButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(16)
        }

        dividerView.snp.makeConstraints {
            $0.bottom.width.equalToSuperview()
            $0.height.equalTo(0.5)
        }
    }

    // MARK: Event
    @objc private func handleDismissButtonEvent() {
        tapDismissButton?()
    }
}
