//
//  BaseRouter.swift
//  AKKIN
//
//  Created by MK-Mac-413 on 2023/09/04.
//

import UIKit
import SafariServices

final class BaseRouter {
    // MARK: Properties
    weak var viewController: UIViewController?

    // MARK: Routing
    func presentSomeViewController() {
        let someViewController = UIViewController()
        someViewController.view.backgroundColor = .white
        viewController?.present(someViewController, animated: true)
    }

    func popViewController() {
        viewController?.navigationController?.popViewController(animated: true)
    }

    func dismissViewController() {
        viewController?.dismiss(animated: true)
    }

    func popToRootViewController() {
        viewController?.dismiss(animated: true, completion: {
            if let rootViewController =
                UIApplication.shared.windows.first?
                .rootViewController {
                if let navigationController =
                    rootViewController as? UINavigationController {
                    navigationController
                        .popToRootViewController(animated: true)
                }
            }
        })
    }

    func presentLoginViewController() {
        let loginViewController = LoginViewController()
        viewController?.navigationController?.pushViewController(loginViewController, animated: true)
    }

    func presentTabBarViewController() {
        let tabBarViewController = TabBarViewController()
        viewController?.navigationController?.pushViewController(tabBarViewController, animated: true)

        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
        sceneDelegate?.changeRootViewToTabBarViewController()
    }

    func presentHomeViewController() {
        let homeViewController = EmptyHomeViewController()
        viewController?.navigationController?.pushViewController(homeViewController, animated: true)
    }

    func popToMakePiggyBankStartViewController() {
        let makePiggyBankViewController = MakePiggyBankStartViewController()
        viewController?.navigationController?.pushViewController(makePiggyBankViewController, animated: true)
    }
    func popToMakePiggyBankEndViewController() {
        let makePiggyBankViewController = MakePiggyBankEndViewController()
        viewController?.navigationController?.pushViewController(makePiggyBankViewController, animated: true)
    }
    func popToMakePiggyBankCompleteViewController() {
        let makePiggyBankViewController = MakePiggyBankCompleteViewController()
        viewController?.navigationController?.pushViewController(makePiggyBankViewController, animated: true)
    }
    func popToPiggyBankDetailViewController(bankId: Int) {
        let piggyBankDetailViewController = PiggyBankDetailViewController()
        piggyBankDetailViewController.bankId = bankId
        piggyBankDetailViewController.hidesBottomBarWhenPushed = true
        viewController?.navigationController?.pushViewController(piggyBankDetailViewController, animated: true)
    }

    func presentAnalysisExpenseViewController() {
        let analysisExpenseViewController = AnalysisExpenseDetailViewController()
        viewController?.navigationController?.pushViewController(analysisExpenseViewController, animated: true)
    }

    func presentCategoryDetailViewController(navigationTitle: String) {
        let categoryDetailViewController = CategoryDetailViewController(navigationTitle: navigationTitle)
        viewController?.navigationController?.pushViewController(categoryDetailViewController, animated: true)
    }

    func presentExpenseListViewController(date: String) {
        let expenseListViewController = ExpenseListViewController(date: date)
        viewController?.navigationController?.pushViewController(expenseListViewController, animated: true)
    }

    func presentExpenseDetailViewController(data: ExpenseData) {
        let expenseDetailViewController = ExpenseDetailViewController(data: data)
        viewController?.navigationController?.pushViewController(expenseDetailViewController, animated: true)
    }

    func presentModeSelectViewController() {
        let selectMonthViewController = SelectMonthViewController()
        viewController?.present(selectMonthViewController, animated: true)
    }

    func presentHomeWidgetSettingViewController() {
        let homeWidgetSettingViewController = HomeWidgetSettingViewController()
        viewController?.navigationController?.pushViewController(homeWidgetSettingViewController, animated: true)
    }

    func presentSafariViewController(url: String) {
        guard let url = URL(string: url) else { return }
        let safariViewController = SFSafariViewController(url: url)
        viewController?.present(safariViewController, animated: true, completion: nil)
    }

    func presentPlanExpenseViewController() {
        let planExpenseViewController = PlanExpenseViewController()
        planExpenseViewController.hidesBottomBarWhenPushed = true
        viewController?.navigationController?.pushViewController(planExpenseViewController, animated: true)
    }

    func presentSetPeriodViewController(_ setPeriodViewController: SetPeriodViewController) {
        setPeriodViewController.modalPresentationStyle = .pageSheet
        if let sheet = setPeriodViewController.sheetPresentationController {
            sheet.detents = [.custom(resolver: { _ in 578 })]
            sheet.preferredCornerRadius = 20
        }
        viewController?.present(setPeriodViewController, animated: true, completion: nil)
    }

    func presentExpenseCategoryViewController(_ expenseCategoryViewController: ExpenseCategoryViewController) {
        expenseCategoryViewController.modalPresentationStyle = .pageSheet
        if let sheet = expenseCategoryViewController.sheetPresentationController {
            sheet.detents = [.custom(resolver: { _ in 578 })]
            sheet.preferredCornerRadius = 20
        }
        viewController?.present(expenseCategoryViewController, animated: true, completion: nil)
    }

    func presentAddExpenseViewController() {
        let addExpenseViewController = AddExpenseViewController()
        addExpenseViewController.hidesBottomBarWhenPushed = true
        viewController?.navigationController?.pushViewController(addExpenseViewController, animated: true)
    }

    func presentAddExpenseConfirmViewController() {
        let addExpenseConfirmViewController = AddExpenseConfirmViewController()
        addExpenseConfirmViewController.hidesBottomBarWhenPushed = true
        viewController?.navigationController?.pushViewController(addExpenseConfirmViewController, animated: true)
    }

}
