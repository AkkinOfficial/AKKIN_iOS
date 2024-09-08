//
//  SetPeriodViewController.swift
//  AKKIN
//
//  Created by 성현주 on 8/16/24.
//

import UIKit

final class SetPeriodViewController: BaseViewController {

    // MARK: UI Components
    private let setPeriodView = SetPeriodView()

    // MARK: Environment
    private let router = BaseRouter()

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setPeriodView.delegate = self
        router.viewController = self
    }

    // MARK: Configuration
    override func configureSubviews() {
        view.addSubview(setPeriodView)
        updateView()

        setPeriodView.tapConfirm = { [weak self] in
            guard let self else { return }
            self.dismiss(animated: true)
        }
    }

    // MARK: Layout
    override func makeConstraints() {
        setPeriodView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    // MARK: method
    func updateView() {
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

        let startDateString = startDate.map { dateFormatter.string(from: $0) } ?? ""
        let endDateString = endDate.map { dateFormatter.string(from: $0) } ?? ""

        let durationString = (startDate != nil && endDate != nil) ? calculateDuration(from: startDate!, to: endDate!) : ""

        setPeriodView.startDateLabel.text = startDateString
        setPeriodView.endDateLabel.text = endDateString.isEmpty ? "" : "\(endDateString) (\(durationString))"
    }

    private func calculateDuration(from startDate: Date, to endDate: Date) -> String {
        let days = Calendar.current.dateComponents([.day], from: startDate, to: endDate).day ?? 0
        return "\(days + 1)일"
    }
}
