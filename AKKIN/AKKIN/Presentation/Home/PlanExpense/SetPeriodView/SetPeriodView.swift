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
    lazy var dateView: UICalendarView = {
        let view = UICalendarView()
        view.wantsDateDecorations = true
        view.availableDateRange = DateInterval(start: .now, end: .distantFuture)
        view.traitCollection.verticalSizeClass
        return view
    }()

    // MARK: Properties

    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()

        addSubview(confirmButton)
        addSubview(dateView)
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

        dateView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

    // MARK: Event
}
