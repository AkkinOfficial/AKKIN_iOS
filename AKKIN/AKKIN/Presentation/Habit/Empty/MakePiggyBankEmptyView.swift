//
//  MakePiggyBankEmptyView.swift
//  AKKIN
//
//  Created by 신종원 on 9/24/24.
//

import UIKit

final class MakePiggyBankEmptyView: BaseView {

    // MARK: UI Components
    private let piggyBankEmptyLabel = UILabel().then {
        $0.text = "아직 만든 저금통이 없어요.\n저금통을 만들어 현명한 절약을 시작해보세요!"
        $0.textColor = .black
        $0.numberOfLines = 2
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    }

    private let piggyBankEmptyButton = BaseButton().then {
        $0.setGuideButton("저금통 만들기")
        $0.isEnabled = true
    }

    // MARK: Properties
    var tapPiggyBankButton: (() -> Void)?

    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()

        backgroundColor = .white
        layer.cornerRadius = 16

        addSubview(piggyBankEmptyLabel)
        addSubview(piggyBankEmptyButton)

        piggyBankEmptyButton.addTarget(self, action: #selector(handleMakePiggyBankButtonEvent), for: .touchUpInside)
    }

    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()

        piggyBankEmptyLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(24)
            $0.centerX.equalToSuperview()
        }

        piggyBankEmptyButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(24)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(48)
        }
    }

    // MARK: Event
    @objc private func handleMakePiggyBankButtonEvent() {
        tapPiggyBankButton?()
    }
}
