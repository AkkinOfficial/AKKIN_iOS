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

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        router.viewController = self
        setData(data: calendarModel)
        setNavigationItem()
    }

    // MARK: Configuration
    override func configureSubviews() {
        view.addSubview(calendarView)
        setUpCalendarView()
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

            let calendar = Calendar.current
            let timeZone = TimeZone(identifier: "Asia/Seoul")!
            var calendarSystem = calendar
            calendarSystem.timeZone = timeZone

            let components = calendarSystem.dateComponents([.month, .day], from: selectedDate)

            if let month = components.month, let day = components.day {
                print("\(month)월 \(day)일")
                calendarModel.month = month
                calendarModel.day = day
                router.presentExpenseListViewController(month: month, day: day)
            }
        }
    }

    func setData(data: CalendarModel) {
        calendarView.monthButton.setTitle(data.month.toMonthFormat, for: .normal)
        calendarView.monthButton.setUnderline()
        calendarView.savingLabel.text = "이번 달 아낀 금액:  " + data.monthSaving.toPriceFormat + "  원"
        calendarView.savingLabel.setColor(targetString: data.monthSaving.toPriceFormat, color: .akkinGreen)
        calendarView.remainingLabel.text = "이번 챌린지 남은 금액:  " + data.monthRemaining.toPriceFormat + "  원"
    }

    // MARK: Navigation Item
    private func setNavigationItem() {
        navigationController?.isNavigationBarHidden = true
    }
}
