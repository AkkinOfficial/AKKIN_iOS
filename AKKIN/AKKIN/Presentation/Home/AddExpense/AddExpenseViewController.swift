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

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboard()

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


        
    }

    // MARK: Layout
    override func makeConstraints() {
        addExpenseView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
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
    func didSelectCategory(icon: UIImage, category: String) {
        addExpenseView.expenseCategoryTextField.addLeftImage(image: icon)
        addExpenseView.expenseCategoryTextField.text = category
    }

}

