//
//  MakePiggyBankViewController.swift
//  AKKIN
//
//  Created by 박지윤 on 8/8/24.
//

import UIKit

final class MakePiggyBankViewController: BaseViewController {

    // MARK: UI Components
    private let makePiggyBankView = MakePiggyBankView()
    private let makePiggyBankCompleteView = MakePiggyBankCompleteView()

    private let backButton = BaseButton().then {
        $0.setImage(AkkinButton.backButton, for: .normal)
    }

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

        backButton.tap = { [self] in
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
        self.navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = "저금통"

        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .akkinWhite
        appearance.shadowColor = nil

        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
}
