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
        $0.numberOfLines = 2
        $0.textAlignment = .center
        $0.textColor = .akkinGray6
        $0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    }

    private let addExpenseButton = BaseButton()

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
            $0.width.equalTo(133)
            $0.height.equalTo(40)
        }
    }

    // MARK: Data
    func setData(message: String, buttonTitle: String) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        paragraphStyle.lineSpacing = 4

        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 14),
            .foregroundColor: UIColor.akkinGray6,
            .paragraphStyle: paragraphStyle
        ]
        
        let attributedString = NSAttributedString(string: message, attributes: attributes)
        
        emptyLabel.attributedText = attributedString
        addExpenseButton.setGuideButton(buttonTitle)
    }
}
