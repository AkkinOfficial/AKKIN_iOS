//
//  HomeWidgetSettingViewController.swift
//  AKKIN
//
//  Created by 박지윤 on 8/30/24.
//

import UIKit

final class HomeWidgetSettingViewController: BaseViewController {

    // MARK: UI Components
    private let homeWidgetSettingView = HomeWidgetSettingView()
    private let backButton = BaseButton().then {
        $0.setImage(AkkinButton.backButton, for: .normal)
    }

    // MARK: Environment
    private let router = BaseRouter()

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        router.viewController = self
        setNavigationItem()
    }

    // MARK: Configuration
    override func configureSubviews() {
        view.addSubview(homeWidgetSettingView)

        backButton.tap = { [self] in
            router.popViewController()
        }
    }

    // MARK: Layout
    override func makeConstraints() {
        homeWidgetSettingView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    // MARK: Navigation Item
    private func setNavigationItem() {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.title = "홈 위젯 설정"
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
}
