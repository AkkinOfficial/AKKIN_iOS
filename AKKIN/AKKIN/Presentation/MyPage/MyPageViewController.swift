//
//  MyPageViewController.swift
//  AKKIN
//
//  Created by 박지윤 on 8/8/24.
//

import UIKit

final class MyPageViewController: BaseViewController {

    // MARK: UI Components
    private let myPageView = MyPageView()

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationItem()
    }

    // MARK: Configuration
    override func configureSubviews() {
        view.addSubview(myPageView)
    }

    // MARK: Layout
    override func makeConstraints() {
        myPageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    // MARK: Navigation Item
    private func setNavigationItem() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "마이페이지"
    }
}
