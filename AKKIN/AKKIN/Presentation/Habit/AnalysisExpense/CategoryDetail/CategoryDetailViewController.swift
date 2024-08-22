//
//  CategoryDetailViewController.swift
//  AKKIN
//
//  Created by 박지윤 on 8/22/24.
//

import UIKit

final class CategoryDetailViewController: BaseViewController {

    let navigationTitle: String

    // MARK: UI Components
    private let backButton = BaseButton().then {
        $0.setImage(AkkinButton.backButton, for: .normal)
    }

    let categoryDetailView = CategoryDetailView()

    // MARK: Environment
    private let router = BaseRouter()

    // MARK: Init
    init(navigationTitle: String) {
        self.navigationTitle = navigationTitle
        super.init(nibName: nil, bundle: nil)
        setNavigationItem(navigationTitle)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        router.viewController = self
    }

    // MARK: Configuration
    override func configureSubviews() {
        view.addSubview(categoryDetailView)

        backButton.tap = { [weak self] in
            guard let self else {
                return }
            router.dismissViewController()
        }
    }

    // MARK: Layout
    override func makeConstraints() {
        categoryDetailView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    // MARK: Navigation Item
    private func setNavigationItem(_ navigationTitle: String) {
        navigationItem.title = navigationTitle
        navigationController?.navigationBar.backgroundColor = .white
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
}
