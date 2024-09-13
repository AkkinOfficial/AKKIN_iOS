//
//  MakePiggyBankCompleteView.swift
//  AKKIN
//
//  Created by 신종원 on 9/2/24.
//

import Foundation
import UIKit

final class MakePiggyBankCompleteView: BaseView {

    // MARK: UI Components
    private let piggyBankEndEmptyView = UIView()

    private let piggyBankEmojiButton = UIButton().then {
        $0.setTitle("💰", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 40, weight: .semibold)
        $0.layer.cornerRadius = 50
        $0.backgroundColor = .akkinGray10
    }
    private let emojiTextField = UITextField().then {
        $0.text = ""
        $0.isHidden = true
    }

    private let piggyBankDateLabel = UILabel().then {
        $0.text = "8월 11일 ~ 8월 15일"
        $0.textColor = .akkinGray6
        $0.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
    }

    private let piggyBankSpendLabel = UILabel().then {
        $0.text = "20,500원"
        $0.textColor = .akkinGreen
        $0.font = UIFont.systemFont(ofSize: 32, weight: .semibold)
    }

    private let piggyBankNameLabel = UILabel().then {
        $0.text = "부모님 생신 선물"
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
    }

    private let piggyBankMemoLabel = UILabel().then {
        $0.text = "어쩌구저쩌구"
        $0.textColor = .akkinGray9
        $0.numberOfLines = 0
        $0.lineBreakMode = .byWordWrapping
        $0.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
    }

    private let piggyBankCompleteButton = BaseButton().then {
        $0.setGuideButton("완료")
    }

    // MARK: Properties
    var tapEmojiButton: (() -> Void)?

    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()

        addSubview(piggyBankEndEmptyView)

        piggyBankEndEmptyView.addSubview(piggyBankDateLabel)
        piggyBankEndEmptyView.addSubview(piggyBankEmojiButton)
        piggyBankEmojiButton.addSubview(emojiTextField)
        piggyBankEndEmptyView.addSubview(piggyBankSpendLabel)
        piggyBankEndEmptyView.addSubview(piggyBankNameLabel)
        piggyBankEndEmptyView.addSubview(piggyBankMemoLabel)
        piggyBankEndEmptyView.addSubview(piggyBankCompleteButton)

        piggyBankEmojiButton.addTarget(self, action: #selector(showEmojiKeyboardEvent), for: .touchUpInside)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
            addGestureRecognizer(tapGesture)
    }

    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()

        piggyBankEndEmptyView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        piggyBankDateLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(118)
            $0.centerX.equalToSuperview()
        }
        piggyBankEmojiButton.snp.makeConstraints {
            $0.top.equalTo(piggyBankDateLabel.snp.bottom).offset(16)
            $0.height.equalTo(100)
            $0.width.equalTo(100)
            $0.centerX.equalToSuperview()
        }
        emojiTextField.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        piggyBankSpendLabel.snp.makeConstraints {
            $0.top.equalTo(piggyBankEmojiButton.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
        }
        piggyBankNameLabel.snp.makeConstraints {
            $0.top.equalTo(piggyBankSpendLabel.snp.bottom).offset(12)
            $0.centerX.equalToSuperview()
        }
        piggyBankMemoLabel.snp.makeConstraints {
            $0.top.equalTo(piggyBankNameLabel.snp.bottom).offset(12)
            $0.centerX.equalToSuperview()
        }
        piggyBankCompleteButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(24)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(56)
        }
    }

    // MARK: Event
    @objc func showEmojiKeyboardEvent() {
        tapEmojiButton?()
        emojiTextField.keyboardType = .default
        emojiTextField.becomeFirstResponder()
        piggyBankEmojiButton.setTitle(emojiTextField.text, for: .normal)
    }
    @objc func dismissKeyboard() {
        endEditing(true)
    }
}
