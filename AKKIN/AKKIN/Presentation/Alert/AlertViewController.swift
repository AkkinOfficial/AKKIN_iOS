//
//  AlertViewController.swift
//  AKKIN
//
//  Created by 성현주 on 11/8/24.
//

import Foundation
import UIKit

class AlertViewController: BaseViewController {

    // MARK: UI Components
    private let alertView = AlertView()

    // MARK: Environment
    private let router = BaseRouter()

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black.withAlphaComponent(0.2)
        router.viewController = self
    }

    // MARK: Configuration
    override func configureSubviews() {
        view.addSubview(alertView)

        alertView.tapConfirm = { [weak self] in
            guard let self else { return }
            router.dismissViewControllerNonAnimated()
        }
    }

    // MARK: Layout
    override func makeConstraints() {
        alertView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

}
