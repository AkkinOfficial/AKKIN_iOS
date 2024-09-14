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

    private let piggyBankNavigationBar = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fill
    }
    let backButton = BackButton()

    private let piggyBankLabel = UILabel().then {
        $0.text = "저금통"
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
    }

    private let piggyBankSettingLabel = UILabel().then {
        $0.text = "저금통의 이름을\n지어주세요"
        $0.textColor = .black
        $0.numberOfLines = 0
        $0.lineBreakMode = .byWordWrapping
        $0.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
    }
    lazy var periodTextField: BaseTextField = {
        let textField = BaseTextField()
        textField.placeholder = "저금통 이름"
        //textField.addLeftImage(image: AkkinIcon.miniCalendar)
        return textField
    }()
    lazy var budgetTextField: BaseTextField = {
        let textField = BaseTextField()
        textField.placeholder = "절약 다짐(선택)"
        //textField.addLeftImage(image: AkkinIcon.tag)
        return textField
    }()
    var piggyBankNextButton = BaseButton().then {
        $0.setGuideButton("다음")
        $0.isEnabled = true
    }

    // MARK: Properties
    var tapPiggyBankNextButton: (() -> Void)?

    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()

        addSubview(emptyView)
        addSubview(piggyBankNavigationBar)
        piggyBankNavigationBar.addSubview(backButton)
        piggyBankNavigationBar.addSubview(piggyBankLabel)

        emptyView.addSubview(piggyBankSettingLabel)
        emptyView.addSubview(piggyBankNextButton)
        emptyView.addSubview(periodTextField)
        emptyView.addSubview(budgetTextField)

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
        }
        backButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(8)
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
        piggyBankNextButton.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(56)
            $0.bottom.equalToSuperview().inset(58)
            $0.centerX.equalToSuperview()
        }
    }

    // MARK: Event
    @objc private func handlePiggyBankNextButtonEvent() {
        tapPiggyBankNextButton?()
    }
}
