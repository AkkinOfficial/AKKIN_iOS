//
//  SetPeriodView.swift
//  AKKIN
//
//  Created by 성현주 on 8/16/24.
//

import UIKit

final class SetPeriodView: BaseView {

    // MARK: UI Components
    lazy var confirmButton: BaseButton = {
        let button = BaseButton()
        button.setTitle(AkkinString.confirmSelect, for: .normal)
        return button
    }()

    // TODO: 캘린더 컴포넌트로 변경

    // MARK: Properties

    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()

        addSubview(confirmButton)
    }

    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()

        confirmButton.snp.makeConstraints {
            $0.width.equalTo(120)
            $0.height.equalTo(52)
            $0.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(16)
        }
    }

    // MARK: Event
}
