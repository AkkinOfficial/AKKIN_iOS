//
//  MakePiggyBankEndView.swift
//  AKKIN
//
//  Created by 신종원 on 9/13/24.
//

import UIKit

final class MakePiggyBankEndView: BaseView {

    // MARK: UI Components
    private let emptyView = UIView()

    var confirmState = false
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

    private let piggyBankSettingLabel = UILabel().then {
        $0.text = "저금통의 이름을\n지어주세요"
        $0.textColor = .black
        $0.numberOfLines = 0
        $0.lineBreakMode = .byWordWrapping
        $0.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
    }
    lazy var nameTextField: BaseTextField = {
        let textField = BaseTextField()
        textField.placeholder = "저금통 이름"
        textField.addLeftImage(image: AkkinIcon.bookmark)
        return textField
    }()
    lazy var memoTextField: UITextView = {
        let textView = UITextView()
        textView.layer.cornerRadius = 16
        textView.text = "절약 다짐(선택)"
        textView.backgroundColor = UIColor.akkinTextFieldBackGround
        textView.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        textView.textColor = .akkinGray6
        textView.textContainerInset = UIEdgeInsets(top: 16, left: 40, bottom: 16, right: 16)
        textView.isScrollEnabled = true
        return textView
    }()

    private let leftImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(resource: .icMemo)
        return imageView
    }()

    let nameCountLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        $0.isHidden = true
    }
    let memoCountLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        $0.isHidden = true
    }
    var piggyBankNextButton = BaseButton().then {
        $0.setCompleteButton(inputTitle: "다음")
        $0.isEnabled = false
    }

    // MARK: Properties
    var tapOutButton: (() -> Void)?
    var tapPiggyBankNextButton: (() -> Void)?

    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()

        addSubview(emptyView)
        addSubview(piggyBankNavigationBar)
        piggyBankNavigationBar.addSubview(backButton)
        piggyBankNavigationBar.addSubview(piggyBankLabel)
        piggyBankNavigationBar.addSubview(piggyBankOutButton)

        emptyView.addSubview(piggyBankSettingLabel)
        emptyView.addSubview(piggyBankNextButton)
        emptyView.addSubview(nameTextField)
        emptyView.addSubview(nameCountLabel)
        emptyView.addSubview(memoTextField)
        memoTextField.addSubview(leftImageView)
        emptyView.addSubview(memoCountLabel)


        piggyBankOutButton.addTarget(self, action: #selector(handlePiggyBankOutButtonEvent), for: .touchUpInside)
        nameTextField.addTarget(self, action: #selector(didTapNameTextField), for: .touchUpInside)
        piggyBankNextButton.addTarget(self, action: #selector(handlePiggyBankNextButtonEvent), for: .touchUpInside)
    }

    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()

        emptyView.snp.makeConstraints {
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

        piggyBankSettingLabel.snp.makeConstraints {
            $0.top.equalTo(piggyBankNavigationBar.snp.bottom).offset(32)
            $0.leading.equalToSuperview().inset(20)
        }
        nameTextField.snp.makeConstraints {
            $0.top.equalTo(piggyBankSettingLabel.snp.bottom).offset(24)
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(56)
        }
        nameCountLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(24)
            $0.top.equalTo(nameTextField.snp.bottom).offset(4)
            $0.width.equalTo(42)
            $0.height.equalTo(22)
        }
        leftImageView.snp.makeConstraints {
            $0.top.equalTo(memoTextField.snp.top).offset(16)
            $0.leading.equalToSuperview().inset(16)
            $0.width.height.equalTo(20)
        }
        memoTextField.snp.makeConstraints {
            $0.top.equalTo(nameTextField.snp.bottom).offset(12)
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(80)
        }
        memoCountLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(24)
            $0.top.equalTo(memoTextField.snp.bottom).offset(4)
            $0.width.equalTo(42)
            $0.height.equalTo(22)
        }
        piggyBankNextButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(24)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(56)
            $0.centerX.equalToSuperview()
        }
    }

    // MARK: Event
    @objc private func handlePiggyBankOutButtonEvent() {
        tapOutButton?()
    }
    @objc private func handlePiggyBankNextButtonEvent() {
        tapPiggyBankNextButton?()
    }
    @objc private func didTapNameTextField() {
        piggyBankNextButton.isEnabled = confirmState
    }
}
