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
    var calendarModel = CalendarModel(month: 9, saving: 40940, remaining: 470150)

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
    }

    // MARK: Layout
    override func makeConstraints() {
        calendarView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    // MARK: Data
    func setData(data: CalendarModel) {
        calendarView.monthButton.setTitle(data.month.toMonthFormat, for: .normal)
        calendarView.monthButton.setUnderline()
        calendarView.savingLabel.text = "이번 달 아낀 금액:  " + data.saving.toPriceFormat + "  원"
        calendarView.savingLabel.setColor(targetString: data.saving.toPriceFormat, color: .akkinGreen)
        calendarView.remainingLabel.text = "이번 챌린지 남은 금액:  " + data.remaining.toPriceFormat + "  원"
    }

    // MARK: Navigation Item
    private func setNavigationItem() {
        navigationController?.isNavigationBarHidden = true
    }
}
