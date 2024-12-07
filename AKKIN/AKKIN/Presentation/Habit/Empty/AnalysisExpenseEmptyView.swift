//
//  AnalysisExpenseEmptyView.swift
//  AKKIN
//
//  Created by 박지윤 on 8/22/24.
//

import UIKit

final class AnalysisExpenseEmptyView: BaseView {

    // MARK: UI Components
    private let contentStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 12
    }

    private let analysisExpenseEmptyLabel = UILabel().then {
        $0.textColor = .black
        $0.numberOfLines = 2
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    }

    private let analysisExpenseEmptyButton = BaseButton().then {
        $0.isEnabled = true
    }

    // MARK: Properties
    var buttonTitle = ""
    var tapButton: ((String) -> Void)?

    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()
        configureView()

        addSubview(contentStackView)
        contentStackView.addArrangedSubviews(analysisExpenseEmptyLabel,
                                             analysisExpenseEmptyButton)

        analysisExpenseEmptyButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }

    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()

        contentStackView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(20)
        }

        analysisExpenseEmptyButton.snp.makeConstraints {
            $0.height.equalTo(48)
        }
    }

    private func configureView() {
        backgroundColor = .white
        layer.cornerRadius = 16
    }

    func configureShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.07
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 8

        snp.makeConstraints {
            $0.height.equalTo(117)
        }
    }

    // MARK: Data
    func setData(message: String, buttonTitle: String, alignment: NSTextAlignment) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = alignment
        paragraphStyle.lineSpacing = 4

        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 14),
            .foregroundColor: UIColor.black,
            .paragraphStyle: paragraphStyle
        ]

        let attributedString = NSAttributedString(string: message, attributes: attributes)

        analysisExpenseEmptyLabel.attributedText = attributedString
        analysisExpenseEmptyButton.setGuideButton(buttonTitle)

        if alignment == .left {
            configureShadow()
        } else {
            snp.makeConstraints {
                $0.height.equalTo(152)
            }
        }
        self.buttonTitle = buttonTitle
    }

    // MARK: Event
    @objc private func didTapButton() {
        tapButton?(buttonTitle)
    }
}
