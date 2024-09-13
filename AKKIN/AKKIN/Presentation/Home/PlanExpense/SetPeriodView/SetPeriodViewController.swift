//
//  SetPeriodViewController.swift
//  AKKIN
//
//  Created by 성현주 on 8/16/24.
//

import UIKit

protocol SetPeriodViewControllerDelegate: AnyObject {
    func didSelectDates(startDate: String, endDate: String, duration: String)
}

final class SetPeriodViewController: BaseViewController {

    // MARK: UI Components
    private let setPeriodView = SetPeriodView()

    // MARK: Properties
    weak var delegate: SetPeriodViewControllerDelegate?
    private var selectedStartDate: String = ""
    private var selectedEndDate: String = ""
    private var selectedDuration: String =  "ㅇㅇ"

    // MARK: Environment
    private let router = BaseRouter()

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        router.viewController = self
    }

    // MARK: Configuration
    override func configureSubviews() {
        view.addSubview(setPeriodView)
        setUpCalendarView()

        setPeriodView.tapConfirm = { [weak self] in
            guard let self else { return }
            router.dismissViewController()
            self.delegate?.didSelectDates(startDate: self.selectedStartDate,
                                          endDate: self.selectedEndDate,
                                          duration: self.selectedDuration)
        }
    }

    // MARK: Layout
    override func makeConstraints() {
        setPeriodView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    // MARK: method
    func setUpCalendarView() {
        setPeriodView.calendarView.onDateSelected = { [weak self] selectedDates in
            guard let self = self else { return }
            self.handleDateSelection(selectedDates: selectedDates)
        }
    }

    private func handleDateSelection(selectedDates: [Date]) {
        switch selectedDates.count {
        case 0:
            resetDateSelection()
        case 1:
            handleSingleDateSelection(startDate: selectedDates.first)
        default:
            handleRangeDateSelection(startDate: selectedDates.first, endDate: selectedDates.last)
        }
    }

    private func resetDateSelection() {
        setPeriodView.confirmButton.isEnabled = false
        setPeriodView.startDateLabel.text = ""
        setPeriodView.endDateLabel.text = ""
        setPeriodView.selectDateLabel.text = "시작일을 선택해주세요"
    }

    private func resetDateSelection() {
        setPeriodView.confirmButton.isEnabled = false
        setPeriodView.startDateLabel.text = ""
        setPeriodView.endDateLabel.text = ""
        setPeriodView.selectDateLabel.text = "시작일을 선택해주세요"
    }

    private func resetDateSelection() {
        setPeriodView.confirmButton.isEnabled = false
        setPeriodView.startDateLabel.text = ""
        setPeriodView.endDateLabel.text = ""
        setPeriodView.selectDateLabel.text = "시작일을 선택해주세요"
    }

    private func handleSingleDateSelection(startDate: Date?) {
        didUpdateDates(startDate: startDate, endDate: nil)
        setPeriodView.confirmButton.isEnabled = false
        setPeriodView.selectDateLabel.text = "종료일을 선택해주세요"
    }

    private func handleRangeDateSelection(startDate: Date?, endDate: Date?) {
        didUpdateDates(startDate: startDate, endDate: endDate)
        setPeriodView.confirmButton.isEnabled = true
    }
}

extension SetPeriodViewController: SetPeriodViewDelegate {
    func didUpdateDates(startDate: Date?, endDate: Date?) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M월 d일"

        selectedStartDate = startDate.map { dateFormatter.string(from: $0) } ?? ""
        selectedEndDate = endDate.map { dateFormatter.string(from: $0) } ?? ""
        selectedDuration = calculateDuration(from: startDate, to: endDate)

        setPeriodView.startDateLabel.text = selectedStartDate
        setPeriodView.endDateLabel.text = selectedEndDate.isEmpty ? "" : "\(selectedEndDate) (\(selectedDuration))"
    }

    private func calculateDuration(from startDate: Date?, to endDate: Date?) -> String {
        guard let startDate = startDate, let endDate = endDate else {
            return ""
        }
        let days = Calendar.current.dateComponents([.day], from: startDate, to: endDate).day ?? 0
        return "\(days + 1)일"
    }
}
