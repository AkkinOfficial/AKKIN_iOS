//
//  BaseRouter.swift
//  AKKIN
//
//  Created by MK-Mac-413 on 2023/09/04.
//

import UIKit

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

    func presentHomeViewController() {
        let homeViewController = HomeViewController()
        viewController?.navigationController?.pushViewController(homeViewController, animated: true)
    }

    func dismissViewController() {
        viewController?.navigationController?.popViewController(animated: true)
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
