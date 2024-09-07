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

    lazy var calendarView: BaseCalendarView = {
        let calendar = BaseCalendarView()
        return calendar
    }()



    // MARK: Properties

    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()

        addSubview(confirmButton)
        addSubview(calendarView)
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
        
        calendarView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(367)
            $0.center.equalToSuperview()
        }
    }

    // MARK: Event
}
