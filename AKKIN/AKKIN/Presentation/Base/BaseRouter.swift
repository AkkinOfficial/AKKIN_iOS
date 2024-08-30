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
        let homeViewController = HomeViewController()
        viewController?.navigationController?.pushViewController(homeViewController, animated: true)
    }

    func presentAnalysisExpenseViewController() {
        let analysisExpenseViewController = AnalysisExpenseDetailViewController()
        viewController?.navigationController?.pushViewController(analysisExpenseViewController, animated: true)
    }

    func presentCategoryDetailViewController(navigationTitle: String) {
        let categoryDetailViewController = CategoryDetailViewController(navigationTitle: navigationTitle)
        viewController?.navigationController?.pushViewController(categoryDetailViewController, animated: true)
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
}
