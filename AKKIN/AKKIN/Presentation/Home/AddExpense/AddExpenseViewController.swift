//
//  AddExpenseViewController.swift
//  AKKIN
//
//  Created by 박지윤 on 8/8/24.
//

import UIKit

final class AddExpenseViewController: BaseViewController {

    // MARK: UI Components
    private let addExpenseView = AddExpenseView()
    let expenseCategoryViewController = ExpenseCategoryViewController()
    let setPeriodViewController = SetPeriodViewController(singleDate: true)

    // MARK: Environment
    private let router = BaseRouter()
    let expenseInfo = ExpenseInfo.shared

    // MARK: Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboard()
        setNavigationItem()

        router.viewController = self
        setPeriodViewController.delegate = self
        expenseCategoryViewController.delegate = self

    }

    // MARK: Configuration
    override func configureSubviews() {
        view.addSubview(addExpenseView)

        addExpenseView.tapCategoryTextField = {
            [weak self] in
            guard let self else { return }
            router.presentExpenseCategoryViewController(expenseCategoryViewController)
        }

        addExpenseView.tapExpenseDayTextField = {
            [weak self] in
            guard let self else { return }
            router.presentSetPeriodViewController(setPeriodViewController)
        }

        addExpenseView.tapConfirmButton = { [weak self] in
            guard let self else { return }
            expenseInfo.amount =  addExpenseView.expenseAmountTextField.text ?? ""
            expenseInfo.category =  addExpenseView.expenseCategoryTextField.text ?? ""
            expenseInfo.content =  addExpenseView.expenseContentTextField.text ?? ""
            expenseInfo.memo = addExpenseView.memoTextField.text ?? ""
            expenseInfo.date =  addExpenseView.expenseDayTextField.text ?? ""

            router.presentAddExpenseConfirmViewController()
        }

        addExpenseView.backButton.tap = { [weak self] in
            guard let self else { return }
            router.popViewController()
        }
    }

    // MARK: Layout
    override func makeConstraints() {
        addExpenseView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    // MARK: Navigation Item
    private func setNavigationItem() {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
}

extension AddExpenseViewController: SetPeriodViewControllerDelegate {

    func didSelectDates(startDate: String, endDate: String, duration: String) {
        addExpenseView.expenseDayTextField.text = "\(startDate)"
        addExpenseView.expenseDayTextField.addRightLabel(text: duration)
    }
}

extension AddExpenseViewController:
    ExpenseCategoryViewControllerDelegate {
    func didSelectCategory(icon: String, category: String) {
        addExpenseView.expenseCategoryTextField.addLeftLabel(text: icon)
        expenseInfo.icon =  icon
        addExpenseView.expenseCategoryTextField.text = category
    }

}

