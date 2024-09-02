//
//  SetPeriodViewController.swift
//  AKKIN
//
//  Created by 성현주 on 8/16/24.
//

import UIKit

final class SetPeriodViewController: BaseViewController {

    // MARK: UI Components
    private let setPeriodView = SetPeriodView()


    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: Configuration
    override func configureSubviews() {
        view.addSubview(setPeriodView)
    }

    // MARK: Layout
    override func makeConstraints() {
        setPeriodView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

