//
//  CalendarViewController.swift
//  AKKIN
//
//  Created by 박지윤 on 8/8/24.
//

import UIKit

final class CalendarViewController: BaseViewController {

    // MARK: UI Components
    private let calendarView = CalendarView()

    // MARK: Environment
    private let router = BaseRouter()

    // MARK: Properties
    var calendarModel = CalendarModel(month: 9, day: 23, monthSaving: 40940, monthRemaining: 470150)
    private var currentYear = DataManager.shared.currentYear ?? 2024
    private var currentMonth = DataManager.shared.currentMonth ?? 11

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
        setUpCalendarView()

        calendarView.tapPrevious = { [self] year, month in
            getSavings(year: year, month: month)
        }

        calendarView.tapNext = { [self] year, month in
            getSavings(year: year, month: month)
        }
    }

    // MARK: Layout
    override func makeConstraints() {
        calendarView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    // MARK: Data
    func setUpCalendarView() {
        calendarView.calendarView.onDateSelected = { [weak self] selectedDate in
            guard let self = self else { return }

            let dateFormatter = DateFormatter()
            dateFormatter.timeZone = TimeZone(identifier: "Asia/Seoul")
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let dateString = dateFormatter.string(from: selectedDate)

            router.presentExpenseListViewController(date: dateString)
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
        NetworkService.shared.savings.getSavings(year: year, month: month) { [self] result in
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

