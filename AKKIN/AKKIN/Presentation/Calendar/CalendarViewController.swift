//
//  CalendarViewController.swift
//  AKKIN
//
//  Created by 박지윤 on 8/8/24.
//

import UIKit
import FSCalendar

final class CalendarViewController: BaseViewController, FSCalendarDelegate {

    // MARK: UI Components
    private let calendarView = CalendarView()

    // MARK: Environment
    private let router = BaseRouter()

    // MARK: Properties
    var calendarModel = CalendarModel(month: 9, day: 23, monthSaving: 40940, monthRemaining: 470150)
    private var currentYear = DataManager.shared.currentYear ?? 2024
    private var currentMonth = DataManager.shared.currentMonth ?? 12
    private var calendar = FSCalendar()

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        getSavings(year: currentYear, month: currentMonth)
        router.viewController = self
        setNavigationItem()
    }

    // MARK: Configuration
    override func configureSubviews() {
        view.addSubview(calendarView)
        setCalendarDelegate()

        calendarView.tapPrevious = { [self] year, month in
            let currentPage = calendar.currentPage
            if let previousMonth = Calendar.current.date(byAdding: .month, value: -1, to: currentPage) {
                calendar.setCurrentPage(previousMonth, animated: true)
            }
            getSavings(year: year, month: month)
        }

        calendarView.tapNext = { [self] year, month in
            let currentPage = calendar.currentPage
            if let nextMonth = Calendar.current.date(byAdding: .month, value: 1, to: currentPage) {
                calendar.setCurrentPage(nextMonth, animated: true)
            }
            getSavings(year: year, month: month)
        }
    }

    private func setCalendarDelegate() {
        calendar = calendarView.calendarView.calendar
        calendar.delegate = self
        calendar.scope = .month
    }

    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        updateButtonTitle(for: calendar.currentPage)
    }

    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Seoul")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: date)

        router.presentExpenseListViewController(date: dateString)
    }

    private func updateButtonTitle(for date: Date) {
        let formatter = DateFormatter()
        formatter.dateFormat = "M월"
        let title = formatter.string(from: date)
        calendarView.monthButton.setTitle("\(title)", for: .normal)
    }

    // MARK: Layout
    override func makeConstraints() {
        calendarView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    // MARK: Navigation Item
    private func setNavigationItem() {
        navigationController?.isNavigationBarHidden = true
    }
}

extension CalendarViewController {
    // MARK: Network
    private func getSavings(year: Int, month: Int) {
        print("💸 getSavings called")
        NetworkService.shared.calendar.getSavings(year: year, month: month) { [self] result in
            switch result {
            case .success(let response):
                guard let data = response as? SavingsResponse else { return }
                print("🎯 getSavings success\n\(data)")
                let totalAmount = totalAmount(from: data.body)
                calendarView.setData(month: month, totalAmount: totalAmount, data: data.body)
                calendarView.calendarView.setSavingsData(data: data.body)
            case .requestErr(let errorResponse):
                dump(errorResponse)
                guard let data = errorResponse as? ErrorResponse else { return }
                // TODO:
                calendarView.setData(month: month, totalAmount: 150000, data: Savings.testSavings)
                calendarView.calendarView.setSavingsData(data: Savings.testSavings)
                print("🤖 \(data)")
            case .serverErr:
                print("serverErr")
            case .networkFail:
                print("networkFail")
            case .pathErr:
                print("pathErr")
            }
        }
    }

    private func totalAmount(from savings: [Savings]) -> Int {
        return savings.reduce(0) { $0 + $1.amount }
    }
}

