//
//  SetPeriodView.swift
//  AKKIN
//
//  Created by 성현주 on 8/16/24.
//

import UIKit

// MARK: protocol
protocol SetPeriodViewDelegate: AnyObject {
    func didUpdateDates(startDate: Date?, endDate: Date?)
}

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

    private let periodStackview = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .equalSpacing
    }

    lazy var selectDateLabel = UILabel().then {
        $0.text = "시작일을 선택해주세요"
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
    }

    lazy var startDateLabel = UILabel().then {
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 12, weight: .medium)
    }

    lazy var dateDivideLabel = UILabel().then {
        $0.text = " - "
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 12, weight: .medium)
    }


    lazy var endDateLabel = UILabel().then {
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 12, weight: .medium)
    }


    // MARK: Properties
    var tapConfirm: (() -> Void)?

    weak var delegate: SetPeriodViewDelegate?

    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()

        addSubview(confirmButton)
        addSubview(calendarView)
        addSubview(selectDateLabel)
        addSubview(periodStackview)

        periodStackview.addArrangedSubviews(startDateLabel,dateDivideLabel,endDateLabel)

        confirmButton.addTarget(self, action: #selector(didTapConfirmButton), for: .touchUpInside)
    }

    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()

        selectDateLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(16)
        }

        periodStackview.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(selectDateLabel.snp.bottom).offset(10)
        }

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
    @objc private func didTapConfirmButton() {
        tapConfirm?()
    }
}
