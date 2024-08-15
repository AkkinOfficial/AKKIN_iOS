//
//  AnalysisExpenseViewController.swift
//  AKKIN
//
//  Created by 박지윤 on 8/8/24.
//

import UIKit

final class AnalysisExpenseViewController: BaseViewController {

    // MARK: UI Components
    private let analysisExpenseView = AnalysisExpenseView()

    private let backButton = BaseButton().then {
        $0.setImage(AkkinButton.backButton, for: .normal)
    }

    private let addButton = BaseButton().then {
        $0.setImage(AkkinButton.addButton, for: .normal)
    }

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationItem()
    }

    // MARK: Configuration
    override func configureSubviews() {
        view.addSubview(analysisExpenseView)
    }

    // MARK: Layout
    override func makeConstraints() {
        analysisExpenseView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
    }

    // MARK: Navigation Item
    private func setNavigationItem() {
        navigationItem.title = "월별 지출 분석"
        navigationController?.navigationBar.backgroundColor = .white
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: addButton)
    }
}
