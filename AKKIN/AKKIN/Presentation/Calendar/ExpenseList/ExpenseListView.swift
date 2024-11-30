//
//  ExpenseListView.swift
//  AKKIN
//
//  Created by 박지윤 on 9/22/24.
//

import UIKit

final class ExpenseListView: BaseView {

    // MARK: UI Components
    private let backButton = BaseButton().then {
        $0.setImage(AkkinButton.backButton.withTintColor(.akkinBlack2), for: .normal)
        $0.isEnabled = true
        $0.backgroundColor = .clear
    }

    private let navigationTitleLabel = UILabel().then {
        $0.text = "지출 내역"
        $0.textColor = .akkinBlack2
        $0.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
    }

    private let addButton = BaseButton().then {
        $0.setImage(AkkinButton.addButton.withTintColor(.akkinBlack2), for: .normal)
        $0.isEnabled = true
        $0.backgroundColor = .clear
    }

    private let dateButtonStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 8
    }

    private let previousDateButton = BaseButton().then {
        $0.setImage(AkkinButton.previousButton, for: .normal)
        $0.isEnabled = true
        $0.backgroundColor = .clear
    }

    let dateButton = BaseButton().then {
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        $0.setTitleColor(.black, for: .normal)
    }

    private let nextDateButton = BaseButton().then {
        $0.setImage(AkkinButton.nextButton, for: .normal)
        $0.isEnabled = true
        $0.backgroundColor = .clear
    }

    let savingLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        $0.textColor = .black
    }

    private let dividerView = UIView().then {
        $0.backgroundColor = .akkinGray8
    }

    // MARK: Properties
    var date: Date?

    var tapBackButtonEvent: (() -> Void)?
    var tapAddButtonEvent: (() -> Void)?

    var tapPrevious: ((Date) -> Void)?
    var tapNext: ((Date) -> Void)?

    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()

        addSubview(backButton)
        addSubview(navigationTitleLabel)
        addSubview(addButton)
        addSubview(savingLabel)

        addSubview(dateButtonStackView)
        dateButtonStackView.addArrangedSubviews(
            previousDateButton,
            dateButton,
            nextDateButton)

        addSubview(dividerView)

        backButton.addTarget(self, action: #selector(handleBackButtonEvent), for: .touchUpInside)
        addButton.addTarget(self, action: #selector(handleAddButtonEvent), for: .touchUpInside)
        previousDateButton.addTarget(self, action: #selector(handlePreviousButtonEvent), for: .touchUpInside)
        nextDateButton.addTarget(self, action: #selector(handleNextButtonEvent), for: .touchUpInside)
    }

    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()

        backButton.snp.makeConstraints {
            $0.centerY.equalTo(navigationTitleLabel)
            $0.leading.equalToSuperview().inset(16)
        }

        navigationTitleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(safeAreaLayoutGuide).inset(15)
        }

        addButton.snp.makeConstraints {
            $0.centerY.equalTo(navigationTitleLabel)
            $0.trailing.equalToSuperview().inset(16)
        }

        dateButtonStackView.snp.makeConstraints {
            $0.top.equalTo(navigationTitleLabel.snp.bottom).offset(47)
            $0.leading.equalToSuperview().inset(16)
        }

        savingLabel.snp.makeConstraints {
            $0.top.equalTo(dateButtonStackView.snp.bottom).offset(20)
            $0.leading.equalToSuperview().inset(20)
        }

        dividerView.snp.makeConstraints {
            $0.top.equalTo(savingLabel.snp.bottom).offset(24)
            $0.bottom.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(16)
        }
    }

    // MARK: Event
    @objc func handleBackButtonEvent() {
        tapBackButtonEvent?()
    }

    @objc func handleAddButtonEvent() {
        tapAddButtonEvent?()
    }
}

extension ExpenseListView {
    // MARK: Set Data
    func setData(date: String, data: Expenses) {
        self.date = DateFormatter.localizedStringToDate(date)

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"

        if let date = formatter.date(from: date) {
            let calendar = Calendar.current
            let month = calendar.component(.month, from: date)
            let day = calendar.component(.day, from: date)
            
            print("Month: \(month), Day: \(day)")
            dateButton.setTitle("\(month)월 \(day)일", for: .normal)
        }
//        dateButton.setUnderline()
        dateButton.isEnabled = true
        dateButton.backgroundColor = .clear

        savingLabel.text = "아낀 금액: " + data.savedAmount.toPriceFormat + " 원"
        savingLabel.setColor(targetString: data.savedAmount.toPriceFormat, color: .akkinGreen)
    }

    func setEmptyData() {
        savingLabel.text = "아낀 금액: 0 원"
    }
}

// MARK: Networking
extension ExpenseListView {
    @objc private func handlePreviousButtonEvent() {
        let calendar = Calendar.current
        if let previousDate = calendar.date(byAdding: .day, value: -1, to: date ?? Date()) {
            date = previousDate
        }

        updateDayButtonTitle()

        tapPrevious?(date ?? Date())
    }

    @objc private func handleNextButtonEvent() {
        let calendar = Calendar.current
        if let nextDate = calendar.date(byAdding: .day, value: 1, to: date ?? Date()) {
            date = nextDate
        }

        updateDayButtonTitle()

        tapNext?(date ?? Date())
    }

    private func updateDayButtonTitle() {
        let dateText = DateFormatter.formatDateToString(date ?? Date(), "MM월 dd일")
        dateButton.setTitle(dateText, for: .normal)
    }
}
