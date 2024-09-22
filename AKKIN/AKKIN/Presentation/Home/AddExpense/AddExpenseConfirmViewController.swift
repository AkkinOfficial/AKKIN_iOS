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

        //TODO: - 네트워크 코드 추가
        addExpenseConfirmView.tapConfirmButton = { [weak self] in
            guard let self else { return }
            router.popViewController()
        }
    }

    // MARK: Layout
    override func makeConstraints() {
        addExpenseConfirmView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    private func setView() {
        addExpenseConfirmView.iconImageView.image = ExpenseInfo.shared.icon
        addExpenseConfirmView.expenseContentLabel.text = ExpenseInfo.shared.content
        addExpenseConfirmView.expenseAmountLabel.text = "\(ExpenseInfo.shared.amount)원"
        addExpenseConfirmView.expenseMemoLabel.text = ExpenseInfo.shared.memo
    }
}

