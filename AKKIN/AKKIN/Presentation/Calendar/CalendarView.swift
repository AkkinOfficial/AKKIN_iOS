//
//  CalendarView.swift
//  AKKIN
//
//  Created by 박지윤 on 8/8/24.
//

import UIKit

final class CalendarView: BaseView {

    // MARK: UI Components
    private let monthButtonStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 8
    }

    private let previousMonthButton = BaseButton().then {
        $0.setImage(AkkinButton.previousButton, for: .normal)
    }

    let monthButton = BaseButton().then {
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        $0.setTitleColor(.black, for: .normal)
        $0.isEnabled = true
        $0.backgroundColor = .clear
    }

    private let nextMonthButton = BaseButton().then {
        $0.setImage(AkkinButton.nextButton, for: .normal)
    }

    let savingLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        $0.textColor = .black
    }

    let remainingLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        $0.textColor = .black
    }

    private let calendarBackgroundView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 16
    }

    lazy var calendarView = BaseCalendarView().then {
        $0.calendar.headerHeight = 0
        $0.calendarMode = .calendar
    }

    // MARK: Properties

    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()
        backgroundColor = .akkinBG

        addSubview(monthButtonStackView)
        monthButtonStackView.addArrangedSubviews(
            previousMonthButton,
            monthButton,
            nextMonthButton)

        addSubview(savingLabel)
        addSubview(remainingLabel)
        addSubview(calendarBackgroundView)
        calendarBackgroundView.addSubview(calendarView)
    }

    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()
        monthButtonStackView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).inset(17)
            $0.centerX.equalToSuperview()
        }

        savingLabel.snp.makeConstraints {
            $0.top.equalTo(monthButtonStackView.snp.bottom).offset(28)
            $0.leading.equalToSuperview().inset(24)
        }

        remainingLabel.snp.makeConstraints {
            $0.top.equalTo(savingLabel.snp.bottom).offset(9)
            $0.leading.equalToSuperview().inset(24)
        }

        calendarBackgroundView.snp.makeConstraints {
            $0.top.equalTo(remainingLabel.snp.bottom).offset(18)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(24)
        }

        calendarView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.verticalEdges.equalToSuperview().inset(20)
        }
    }

    // MARK: Event

}

