//
//  MakePiggyBankStartView.swift
//  AKKIN
//
//  Created by 신종원 on 9/13/24.
//

import UIKit

final class MakePiggyBankStartView: BaseView {

    // MARK: UI Components
    private let emptyView = UIView()

    private let piggyBankNavigationBar = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fill
    }
    let backButton = BaseButton().then {
        $0.setBackButton()
    }

    private let piggyBankLabel = UILabel().then {
        $0.text = "저금통"
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
    }

    private let piggyBankSettingLabel = UILabel().then {
        $0.text = "목표 기한과\n저축 금액을 설정해주세요"
        $0.textColor = .black
        $0.numberOfLines = 0
        $0.lineBreakMode = .byWordWrapping
        $0.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
    }
    lazy var periodTextField: BaseTextField = {
        let textField = BaseTextField()
        textField.placeholder = "목표 기한"
        //textField.addLeftImage(image: AkkinIcon.miniCalendar)
        return textField
    }()
    lazy var budgetTextField: BaseTextField = {
        let textField = BaseTextField()
        textField.placeholder = "목표 저축 금액"
        textField.addRightLabel(text: "원", textColor: .akkinGray6)
        textField.addCommas()
        //textField.addLeftImage(image: AkkinIcon.tag)
        return textField
    }()
    private let memoLabel = UILabel().then {
        $0.text = "아무런 지출도 하지 않았을 때\n최대 75,000원까지 아낄 수 있어요."
        $0.textColor = .akkinGreen
        $0.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        $0.numberOfLines = 2
        $0.isHidden = true
    }
    var piggyBankNextButton = BaseButton().then {
        $0.setCompleteButton(inputTitle: "다음")
        $0.isEnabled = false
    }

    // MARK: Properties
    var tapPiggyBankNextButton: (() -> Void)?

    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()

        addSubview(emptyView)
        emptyView.addSubview(piggyBankNavigationBar)
        piggyBankNavigationBar.addSubview(backButton)
        piggyBankNavigationBar.addSubview(piggyBankLabel)

        emptyView.addSubview(piggyBankSettingLabel)
        addSubview(piggyBankNextButton)
        emptyView.addSubview(periodTextField)
        emptyView.addSubview(budgetTextField)
        emptyView.addSubview(memoLabel)

        periodTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        budgetTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
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
            $0.height.equalTo(56)
            $0.horizontalEdges.equalToSuperview()
        }
        backButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(4)
            $0.width.equalTo(48)
            $0.height.equalTo(48)
            $0.centerY.equalToSuperview()
        }
        piggyBankLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }

        piggyBankSettingLabel.snp.makeConstraints {
            $0.top.equalTo(piggyBankNavigationBar.snp.bottom).offset(32)
            $0.leading.equalToSuperview().inset(20)
        }
        periodTextField.snp.makeConstraints {
            $0.top.equalTo(piggyBankSettingLabel.snp.bottom).offset(24)
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(56)
        }
        budgetTextField.snp.makeConstraints {
            $0.top.equalTo(periodTextField.snp.bottom).offset(12)
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(56)
        }
        memoLabel.snp.makeConstraints {
            $0.top.equalTo(budgetTextField.snp.bottom).offset(8)
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(44)
        } 
        piggyBankNextButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(24)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(56)
            $0.centerX.equalToSuperview()
        }
    }

    // MARK: Event
    @objc private func handlePiggyBankNextButtonEvent() {
        tapPiggyBankNextButton?()
        budgetTextField.resignFirstResponder()
    }
    @objc func textFieldDidChange() {
        if (!(budgetTextField.text?.isEmpty ?? true)) {
            let duration = 9
            let availableAmount = 13000
            let inputText = duration * availableAmount
            memoLabel.text = "아무런 지출도 하지 않았을 때\n최대 \(inputText)원까지 아낄 수 있어요."
            memoLabel.isHidden = false

        } else {
            memoLabel.isHidden = true
        }
        piggyBankNextButton.isEnabled = !(periodTextField.text?.isEmpty ?? true) && !(budgetTextField.text?.isEmpty ?? true)
    }
}
