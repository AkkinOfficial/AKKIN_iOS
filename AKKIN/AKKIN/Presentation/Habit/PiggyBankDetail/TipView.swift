//
//  TipView.swift
//  AKKIN
//
//  Created by 신종원 on 10/5/24.
//

import Foundation
import UIKit

final class TipView: BaseView {

    // MARK: UI Components
    let imageLabel = UILabel().then {
        $0.text = "🏃🏻"
        $0.font = UIFont.systemFont(ofSize: 16)
    }

    let tipTitleLabel = UILabel().then {
        $0.text = "2km이내 거리는 걸어가기"
        $0.textColor = .akkinBlack2
        $0.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
    }

    let tipMemoLabel = UILabel().then {
        $0.text = "평균적으로 왕복 교통비 3,000원을 아낄 수 있어요"
        $0.textColor = .akkinBlack2
        $0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    }

    // MARK: Properties

    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()
        backgroundColor = .akkinGray10
        layer.cornerRadius = 16

        addSubview(imageLabel)
        addSubview(tipTitleLabel)
        addSubview(tipMemoLabel)
    }

    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()

        imageLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.top.equalToSuperview().inset(16)
            $0.height.width.equalTo(18)
        }
        tipTitleLabel.snp.makeConstraints {
            $0.leading.equalTo(imageLabel.snp.trailing).offset(6)
            $0.top.equalToSuperview().inset(16)
            $0.height.equalTo(19)
            $0.width.equalTo(288)
        }
        tipMemoLabel.snp.makeConstraints {
            $0.top.equalTo(tipTitleLabel.snp.bottom).offset(8)
            $0.leading.equalTo(imageLabel.snp.leading)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(19)
        }
    }

    // MARK: Event
}
