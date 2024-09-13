//
//  MakePiggyBankStartView.swift
//  AKKIN
//
//  Created by 박지윤 on 8/8/24.
//

import UIKit

final class MakePiggyBankStartView: BaseView {

    // MARK: UI Components
    private let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
    }

    private let piggyBankStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fill
    }

    private let piggyBankSettingLabel = UILabel().then {
        $0.text = "목표 기한과\n저축 금액을 설정해주세요"
        $0.textColor = .black
        $0.numberOfLines = 0
        $0.lineBreakMode = .byWordWrapping
        $0.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
    }

    var piggyBankNextButton = BaseButton().then {
        $0.setGuideButton("다음")
        $0.isEnabled = false
    }

    // MARK: Properties
    var tapPiggyBankNextButton: (() -> Void)?

    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()

        addSubview(scrollView)

        scrollView.addSubview(piggyBankStackView)
        piggyBankStackView.addSubview(piggyBankSettingLabel)
        piggyBankStackView.addSubview(piggyBankNextButton)

        piggyBankNextButton.addTarget(self, action: #selector(handlePiggyBankNextButtonEvent), for: .touchUpInside)
    }

    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()

        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        piggyBankSettingLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(32)
            $0.leading.equalToSuperview().inset(24)
        }
        piggyBankNextButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(32)
            $0.leading.equalToSuperview().inset(24)
        }
    }

    // MARK: Event
    @objc private func handlePiggyBankNextButtonEvent() {
        tapPiggyBankNextButton?()
    }
}
