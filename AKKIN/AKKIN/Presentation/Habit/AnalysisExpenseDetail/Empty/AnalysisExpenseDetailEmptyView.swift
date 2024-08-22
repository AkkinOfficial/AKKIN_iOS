//
//  AnalysisExpenseDetailEmptyView.swift
//  AKKIN
//
//  Created by 박지윤 on 8/22/24.
//

import UIKit

final class AnalysisExpenseDetailEmptyView: BaseView {

    // MARK: UI Components
    private let emptyStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 40
        $0.distribution = .fill
        $0.alignment = .center
    }

    private let emptyBillImageView = UIImageView().then {
        $0.image = AkkinImage.emptyBill
    }

    private let emptyLabel = UILabel().then {
        $0.attributedText = "아직 분석할 수 있는 지출 기록이 없어요.\n지출을 계획하고 절약을 시작해보세요!".setLineSpacing(4)
        $0.numberOfLines = 2
        $0.textAlignment = .center
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    }

    private let addExpenseButton = BaseButton().then {
        $0.setGuideButton("지출 추가하기")
    }

    // MARK: Properties

    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()

        addSubview(emptyStackView)

        emptyStackView.addArrangedSubviews(emptyBillImageView,
                                           emptyLabel,
                                           addExpenseButton)
    }

    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()

        emptyStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        emptyBillImageView.snp.makeConstraints {
            $0.width.equalTo(145)
            $0.height.equalTo(86)
        }

        addExpenseButton.snp.makeConstraints {
            $0.width.equalTo(119)
            $0.height.equalTo(40)
        }
    }

    // MARK: Event
}
