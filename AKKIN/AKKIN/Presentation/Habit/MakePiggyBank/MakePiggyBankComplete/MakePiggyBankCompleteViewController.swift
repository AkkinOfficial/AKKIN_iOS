//
//  MakePiggyBankCompleteViewController.swift
//  AKKIN
//
//  Created by 신종원 on 9/14/24.
//

import UIKit

final class MakePiggyBankCompleteViewController: BaseViewController, UITextFieldDelegate {

    // MARK: UI Components
    private let makePiggyBankCompleteView = MakePiggyBankCompleteView()

    // MARK: Environment
    private let router = BaseRouter()

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationItem()
        router.viewController = self
    }

    // MARK: Configuration
    override func configureSubviews() {
        view.addSubview(makePiggyBankCompleteView)

        makePiggyBankCompleteView.backButton.tap = { [self] in
            router.popViewController()
        }
        makePiggyBankCompleteView.piggyBankCompleteButton.tap = { [weak self] in
            guard let self else { return }
            router.popToRootViewController()
        }
    }

    // MARK: Layout
    override func makeConstraints() {
        makePiggyBankCompleteView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }

    // MARK: Navigation Item
    private func setNavigationItem() {
        navigationController?.isNavigationBarHidden = true
    }
}
