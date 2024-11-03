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

    private let piggyBankNavigationBar = UIView()
    let backButton = BaseButton().then {
        $0.setBackButton()
    }
    private let piggyBankLabel = UILabel().then {
        $0.text = "저금통"
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
    }
    let piggyBankOutButton = UIButton().then {
        $0.setTitle("나가기", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        $0.setTitleColor(.akkinGreen, for: .normal)
    }

    private let emojiTextView = UIView().then {
        $0.backgroundColor = UIColor.akkinTextFieldBackGround
        $0.layer.cornerRadius = 50
    }

    let emojiTextField = EmojiTextField().then {
        $0.text = "💰"
        $0.font = UIFont.systemFont(ofSize: 40, weight: .semibold)
        $0.tintColor = .clear
    }

    let piggyBankDateLabel = UILabel().then {
        $0.text = "8월 11일 ~ 8월 15일"
        $0.textColor = .akkinGray6
        $0.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
    }

    let piggyBankSpendLabel = UILabel().then {
        $0.text = "20,500원"
        $0.textColor = .akkinGreen
        $0.font = UIFont.systemFont(ofSize: 32, weight: .semibold)
    }

    let piggyBankNameLabel = UILabel().then {
        $0.text = "부모님 생신 선물"
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
    }

    let piggyBankMemoLabel = UILabel().then {
        $0.text = "어쩌구저쩌구"
        $0.textColor = .akkinGray9
        $0.numberOfLines = 0
        $0.lineBreakMode = .byWordWrapping
        $0.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
    }

    let piggyBankCompleteButton = BaseButton().then {
        $0.isEnabled = true
        $0.setTitle("완료", for: .normal)
    }

    // MARK: Properties
    var tapOutButton: (() -> Void)?
    var tapEmojiButton: (() -> Void)?

    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()

        addSubview(piggyBankEndEmptyView)
        piggyBankEndEmptyView.addSubview(piggyBankNavigationBar)
        piggyBankNavigationBar.addSubview(backButton)
        piggyBankNavigationBar.addSubview(piggyBankLabel)
        piggyBankNavigationBar.addSubview(piggyBankOutButton)

        piggyBankEndEmptyView.addSubview(piggyBankDateLabel)
        piggyBankEndEmptyView.addSubview(emojiTextView)
        emojiTextView.addSubview(emojiTextField)
        piggyBankEndEmptyView.addSubview(piggyBankSpendLabel)
        piggyBankEndEmptyView.addSubview(piggyBankNameLabel)
        piggyBankEndEmptyView.addSubview(piggyBankMemoLabel)
        piggyBankEndEmptyView.addSubview(piggyBankCompleteButton)


        piggyBankOutButton.addTarget(self, action: #selector(handlePiggyBankOutButtonEvent), for: .touchUpInside)
        emojiTextField.addTarget(self, action: #selector(showEmojiKeyboardEvent), for: .touchUpInside)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
            addGestureRecognizer(tapGesture)
    }

    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()

        piggyBankEndEmptyView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        piggyBankNavigationBar.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(56)
        }
        backButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(4)
            $0.width.equalTo(48)
            $0.height.equalTo(48)
            $0.centerY.equalToSuperview()
        }
        piggyBankLabel.snp.makeConstraints {
            $0.width.equalTo(48)
            $0.height.equalTo(26)
            $0.centerX.centerY.equalToSuperview()
        }
        piggyBankOutButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(24)
        }

        piggyBankDateLabel.snp.makeConstraints {
            $0.top.equalTo(piggyBankNavigationBar.snp.bottom).offset(118)
            $0.centerX.equalToSuperview()
        }
        emojiTextView.snp.makeConstraints {
            $0.top.equalTo(piggyBankDateLabel.snp.bottom).offset(16)
            $0.width.height.equalTo(100)
            $0.centerX.equalToSuperview()
        }
        emojiTextField.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        piggyBankSpendLabel.snp.makeConstraints {
            $0.top.equalTo(emojiTextView.snp.bottom).offset(16)
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
    @objc private func handlePiggyBankOutButtonEvent() {
        tapOutButton?()
    }
    @objc func showEmojiKeyboardEvent() {
        tapEmojiButton?()
        emojiTextField.text = ""
        emojiTextField.becomeFirstResponder()
    }
    @objc func dismissKeyboard() {
        endEditing(true)
    }
}
