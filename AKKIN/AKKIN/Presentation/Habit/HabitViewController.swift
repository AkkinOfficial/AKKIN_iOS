//
//  HabitViewController.swift
//  AKKIN
//
//  Created by 박지윤 on 8/8/24.
//

import UIKit

final class HabitViewController: BaseViewController {

    // MARK: UI Components
    private let habitView = HabitView()

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationItem()
    }

    // MARK: Configuration
    override func configureSubviews() {
        view.addSubview(habitView)
        habitView.backgroundColor = .akkinBG
    }

    // MARK: Layout
    override func makeConstraints() {
        habitView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }

    // MARK: Navigation Item
    private func setNavigationItem() {
        navigationController?.navigationBar.prefersLargeTitles = true

        let defaultAppearance = UINavigationBarAppearance()
        defaultAppearance.backgroundColor = .akkinBG

        let scrollAppearance = UINavigationBarAppearance()
        scrollAppearance.backgroundColor = .akkinBG
        scrollAppearance.shadowColor = nil

        navigationController?.navigationBar.standardAppearance = defaultAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = scrollAppearance
    }
}
