//
//  ExpenseListViewController.swift
//  AKKIN
//
//  Created by 박지윤 on 9/22/24.
//

import UIKit

final class ExpenseListViewController: BaseViewController {

    // MARK: UI Components
    private let expenseListView = ExpenseListView()

    // MARK: Environment
    private let router = BaseRouter()

    // MARK: Properties
    var calendarModel = CalendarModel(month: 9, day: 23, monthSaving: 40940, monthRemaining: 470150)

    // MARK: Init
    init(month: Int, day: Int) {
        self.calendarModel.month = month
        self.calendarModel.day = day
        super.init(nibName: nil, bundle: nil)
        getData(month: calendarModel.month, day: calendarModel.day)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationItem()

        router.viewController = self
    }

    // MARK: Configuration
    override func configureSubviews() {
        view.addSubview(expenseListView)

        expenseListView.tapBackButtonEvent = { [self] in
            router.popViewController()
        }

        expenseListView.tapAddButtonEvent = { [self] in
            print("tap add button")
        }
    }

    // MARK: Layout
    override func makeConstraints() {
        expenseListView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    // MARK: Navigation Item
    private func setNavigationItem() {
        navigationController?.isNavigationBarHidden = true
    }

    // MARK: Data
    func getData(month: Int, day: Int) {
        calendarModel.daySaving = 8190
        setData(data: calendarModel)
    }

    func setData(data: CalendarModel) {
        let month = data.month.toMonthFormat
        let day = data.day.toDayFormat

        expenseListView.dateButton.setTitle(month + " " + day, for: .normal)
        expenseListView.dateButton.setUnderline()
        expenseListView.dateButton.isEnabled = true
        expenseListView.dateButton.backgroundColor = .clear

        let daySaving = data.daySaving?.toPriceFormat ?? "nil"
        expenseListView.savingLabel.text = "아낀 금액: " + daySaving + " 원"
        expenseListView.savingLabel.setColor(targetString: daySaving, color: .akkinGreen)
    }
}
