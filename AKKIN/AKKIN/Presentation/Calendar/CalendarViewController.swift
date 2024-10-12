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
    let today = Date()
    let calendar = Calendar.current

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        let year = calendar.component(.year, from: today)
        let month = calendar.component(.month, from: today)
        getSavings(year: year, month: month)
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

            let dateFormatter = DateFormatter()
            dateFormatter.timeZone = TimeZone(identifier: "Asia/Seoul")
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let dateString = dateFormatter.string(from: selectedDate)

            router.presentExpenseListViewController(date: dateString)
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

extension CalendarViewController {
    // MARK: Network
    private func getSavings(year: Int, month: Int) {
        print("💸 getSavings called")
        NetworkService.shared.savings.getSavings(year: year, month: month) { [self] result in
            switch result {
            case .success(let response):
                guard let data = response as? SavingsResponse else { return }
                print("🎯 getSavings success\n\(data)")
            case .requestErr(let errorResponse):
                dump(errorResponse)
                guard let data = errorResponse as? ErrorResponse else { return }
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
}

