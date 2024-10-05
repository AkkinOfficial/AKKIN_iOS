//
//  AddExpenseConfirmViewController.swift
//  AKKIN
//
//  Created by 성현주 on 9/22/24.
//

import UIKit

final class AddExpenseConfirmViewController: BaseViewController {

    // MARK: UI Components
    private let addExpenseConfirmView = AddExpenseConfirmView()

    // MARK: Environment
    private let router = BaseRouter()
    private let addExpenseService = AddExpenseService()

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        router.viewController = self
    }

    // MARK: Configuration
    override func configureSubviews() {
        print(ExpenseInfo.shared.amount, ExpenseInfo.shared.category, ExpenseInfo.shared.content)
        setView()
        view.addSubview(addExpenseConfirmView)

        addExpenseConfirmView.tapConfirmButton = { [weak self] in
            guard let self else { return }
            addExpense()
            //TODO: - 네트워크 성공후 rootview로 이동
            router.popToRootViewController()
        }
    }

    // MARK: Layout
    override func makeConstraints() {
        addExpenseConfirmView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    private func setView() {
        addExpenseConfirmView.iconImageView.text = ExpenseInfo.shared.icon
        addExpenseConfirmView.expenseContentLabel.text = ExpenseInfo.shared.content
        addExpenseConfirmView.expenseAmountLabel.text = "\(ExpenseInfo.shared.amount)원"
        addExpenseConfirmView.expenseMemoLabel.text = ExpenseInfo.shared.memo
    }

    private func addExpense() {
        let amountString = ExpenseInfo.shared.amount.replacingOccurrences(of: ",", with: "")
        guard let amount = Int(amountString) else {
            print("Invalid amount: \(ExpenseInfo.shared.amount)")
            return
        }

        let request = AddExpenseRequest(
            amount: amount,
            content: ExpenseInfo.shared.content,
            memo: ExpenseInfo.shared.memo,
            date: ExpenseInfo.shared.date,
            category: ExpenseInfo.shared.category
        )

        addExpenseService.postAddExpense(request: request) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let response):
                if let addExpenseResponse = response as? AddExpenseResponse {
                    print("Expense added successfully: \(addExpenseResponse)")
                }
            case .requestErr(let errorResponse):
                print("Request error: \(errorResponse)")
            case .serverErr:
                print("Server error")
            case .networkFail:
                print("Network failure")
            case .pathErr:
                print("Path error")
            }
        }
    }
}

