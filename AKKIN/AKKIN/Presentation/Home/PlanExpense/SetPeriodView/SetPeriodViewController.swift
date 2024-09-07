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


    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setPeriodView.delegate = self
    }

    // MARK: Configuration
    override func configureSubviews() {
        view.addSubview(setPeriodView)
        updateView()
    }

    // MARK: Layout
    override func makeConstraints() {
        setPeriodView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func updateView() {
        setPeriodView.calendarView.onDateSelected = { [weak self] selectedDates in
            guard let self = self else { return }


            if selectedDates.count == 1 {
                self.didUpdateDates(startDate: selectedDates.first, endDate: nil)
            }else{
                self.didUpdateDates(startDate: selectedDates.first, endDate: selectedDates.last)
                setPeriodView.confirmButton.isEnabled = true
            }
        }
    }

}

extension SetPeriodViewController: SetPeriodViewDelegate {
    func didUpdateDates(startDate: Date?, endDate: Date?) {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M월 d일"

        let startDateString = startDate != nil ? dateFormatter.string(from: startDate!) : ""
        let endDateString = endDate != nil ? dateFormatter.string(from: endDate!) : ""

        print("Start Date: \(startDateString), End Date: \(endDateString)")
        setPeriodView.startDateLabel.text = startDateString
        setPeriodView.endDateLabel.text = endDateString
    }
}
