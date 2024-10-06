//
//  PiggyBankDetailView.swift
//  AKKIN
//
//  Created by 신종원 on 10/4/24.
//

import Foundation
import UIKit

final class PiggyBankDetailView: BaseView {

    // MARK: UI Components
    private let piggyBankNavigationBar = UIView()
    let backButton = BaseButton().then {
        $0.setBackButton()
    }
    private let piggyBankLabel = UILabel().then {
        $0.text = "저금통"
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
    }
    let piggyBankAlertButton = UIButton().then {
        $0.setImage(AkkinButton.kebabButton, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        $0.setTitleColor(.akkinGreen, for: .normal)
    }
    private let tipView = TipView()

    private let piggyBankName = UILabel().then {
        $0.text = "아이패드 사기"
        $0.textColor = .akkinBlack2
        $0.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
    }
    private let piggyBankDate = UILabel().then {
        $0.text = "mm.dd - mm.dd"
        $0.textColor = .akkinGray6
        $0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    }
    lazy var progressView : CustomProgressView = {
        let progressView = CustomProgressView()
        return progressView
    }()
    private let piggyBankScoreEmoji = UILabel().then {
        $0.text = "🍎"
        $0.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
    }
    let piggyBankScore = UILabel().then {
        $0.text = "5% 달성"
        $0.textColor = .akkinGreen
        $0.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
    }
    private let parentStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
    }
    private let saveStackview = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .fill
        $0.alignment = .fill
        $0.spacing = 12
    }
    lazy var savedLabel: UILabel = {
        let label = UILabel()
        label.text = "모은 금액"
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textAlignment = .center
        return label
    }()

    lazy var saveAmountLabel: UILabel = {
        let label = UILabel()
        label.text = "57,420원"
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    private let slashStackview = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .fill
        $0.alignment = .fill
        $0.spacing = 12
    }
    lazy var emptySlashLabel: UILabel = {
        let label = UILabel()
        label.text = "   "
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textAlignment = .center
        return label
    }()
    lazy var slashLabel: UILabel = {
        let label = UILabel()
        label.text = "/"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    private let challengeStackview = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .fill
        $0.alignment = .fill
        $0.spacing = 12
    }
    lazy var challengeLabel: UILabel = {
        let label = UILabel()
        label.text = "목표 금액"
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textAlignment = .center
        return label
    }()

    lazy var challengeAmountLabel: UILabel = {
        let label = UILabel()
        label.text = "638,000원"
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textAlignment = .center
        return label
    }()

    // MARK: Properties
    var tapOutButton: (() -> Void)?

    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()

        addSubview(piggyBankNavigationBar)
        piggyBankNavigationBar.addSubview(backButton)
        piggyBankNavigationBar.addSubview(piggyBankLabel)
        piggyBankNavigationBar.addSubview(piggyBankAlertButton)

        addSubview(tipView)
        addSubview(piggyBankName)
        addSubview(piggyBankDate)
        addSubview(progressView)
        addSubview(piggyBankScoreEmoji)
        addSubview(piggyBankScore)
        addSubview(parentStackView)

        parentStackView.addArrangedSubviews(saveStackview, slashStackview, challengeStackview)
        saveStackview.addArrangedSubviews(savedLabel, saveAmountLabel)
        slashStackview.addArrangedSubviews(emptySlashLabel, slashLabel)
        challengeStackview.addArrangedSubviews(challengeLabel, challengeAmountLabel)
        progressView.addSubview(piggyBankScoreEmoji)
        progressView.addSubview(piggyBankScore)

        piggyBankAlertButton.addTarget(self, action: #selector(handlePiggyBankOutButtonEvent), for: .touchUpInside)
    }

    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()

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
        piggyBankAlertButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(24)
        }
        tipView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(72)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(76)
            $0.width.equalTo(335)
        }
        piggyBankName.snp.makeConstraints {
            $0.top.equalTo(tipView.snp.bottom).offset(40)
            $0.centerX.equalToSuperview()
        }
        piggyBankDate.snp.makeConstraints {
            $0.top.equalTo(piggyBankName.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
        }
        progressView.snp.makeConstraints {
            $0.top.equalTo(piggyBankDate.snp.bottom).offset(32)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(180)
        }
        piggyBankScoreEmoji.snp.makeConstraints {
            $0.top.equalTo(piggyBankDate.snp.bottom).offset(86.5)
            $0.centerX.equalToSuperview()
        }
        piggyBankScore.snp.makeConstraints {
            $0.top.equalTo(piggyBankScoreEmoji.snp.bottom).offset(6)
            $0.centerX.equalToSuperview()
        }
        parentStackView.snp.makeConstraints {
            $0.top.equalTo(progressView.snp.bottom).offset(50)
            $0.horizontalEdges.equalToSuperview().inset(65)
        }
    }

    // MARK: Event
    @objc private func handlePiggyBankOutButtonEvent() {
        tapOutButton?()
    }
}
