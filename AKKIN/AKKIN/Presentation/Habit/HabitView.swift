//
//  HabitView.swift
//  AKKIN
//
//  Created by 박지윤 on 8/8/24.
//

import UIKit

final class HabitView: BaseView {

    // MARK: UI Components
    private let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
    }

    private let moneyBoxView = UIView()

    private let moneyBoxStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fill
    }

    private let moneyBoxLabel = UILabel().then {
        $0.text = "저금통"
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
    }

    private let addButton = BaseButton().then {
        $0.setImage(AkkinButton.addButton, for: .normal)
        $0.isHidden = true
    }

    private let moneyBoxEmptyView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 16
    }

    private let moneyBoxEmptyLabel = UILabel().then {
        $0.text = "아직 만든 저금통이 없어요.\n저금통을 만들어 현명한 절약을 시작해보세요!"
        $0.textColor = .black
        $0.numberOfLines = 2
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    }

    private let moneyBoxEmptyButton = BaseButton().then {
        $0.setTitle("저금통 만들기", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .akkinGreen
        $0.layer.cornerRadius = 12
    }

    private let analysisExpenseView = UIView()
    private let analysisExpenseStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 4
        $0.alignment = .leading
    }

    private let analysisExpenseLabel = UILabel().then {
        $0.text = "지출분석"
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
    }

    private let detailButton = BaseButton().then {
        $0.setImage(AkkinButton.detailButton, for: .normal)
        $0.isHidden = true
    }

    private let emtpyView = UIView().then {
        $0.backgroundColor = .clear
    }

    private let analysisExpenseEmptyView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 16
    }

    private let analysisExpenseEmptyLabel = UILabel().then {
        $0.text = "분석할 수 있는 지출 기록이 없어요.\n본인의 지출을 계획하고 절약을 시작해보세요!"
        $0.textColor = .black
        $0.numberOfLines = 2
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    }

    private let analysisExpenseEmptyButton = BaseButton().then {
        $0.setTitle("지출 계획하기", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .akkinGreen
        $0.layer.cornerRadius = 12
    }

    // MARK: Properties

    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()
        backgroundColor = .akkinBG

        addSubview(scrollView)

        scrollView.addSubview(moneyBoxView)
        moneyBoxView.addSubview(moneyBoxStackView)
        moneyBoxView.addSubview(moneyBoxEmptyView)

        moneyBoxEmptyView.addSubview(moneyBoxEmptyLabel)
        moneyBoxEmptyView.addSubview(moneyBoxEmptyButton)

        scrollView.addSubview(analysisExpenseView)
        analysisExpenseView.addSubview(analysisExpenseStackView)
        analysisExpenseView.addSubview(analysisExpenseEmptyView)

        analysisExpenseEmptyView.addSubview(analysisExpenseEmptyLabel)
        analysisExpenseEmptyView.addSubview(analysisExpenseEmptyButton)

        moneyBoxStackView.addArrangedSubviews(moneyBoxLabel, addButton)
        analysisExpenseStackView.addArrangedSubviews(analysisExpenseLabel, detailButton, emtpyView)
    }

    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()

        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        moneyBoxView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(31)
            $0.width.equalToSuperview()
            $0.height.equalTo(198)
        }

        moneyBoxStackView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(24)
            $0.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(48)
        }

        moneyBoxLabel.snp.makeConstraints {
            $0.centerY.equalTo(moneyBoxStackView.snp.centerY)
        }

        addButton.snp.makeConstraints {
            $0.centerY.equalTo(moneyBoxStackView.snp.centerY)
        }

        moneyBoxEmptyView.snp.makeConstraints {
            $0.top.equalTo(moneyBoxStackView.snp.bottom).offset(10)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(142)
        }

        moneyBoxEmptyLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(24)
            $0.centerX.equalToSuperview()
        }

        moneyBoxEmptyButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(24)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(48)
        }

        analysisExpenseView.snp.makeConstraints {
            $0.top.equalTo(moneyBoxView.snp.bottom).offset(40)
            $0.width.equalToSuperview()
            $0.height.equalTo(198)
            $0.bottom.equalToSuperview().inset(20)
        }

        analysisExpenseStackView.snp.makeConstraints {
            $0.top.equalTo(moneyBoxView.snp.bottom).offset(47)
            $0.leading.equalToSuperview().inset(24)
            $0.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(48)
        }

        analysisExpenseLabel.snp.makeConstraints {
            $0.centerY.equalTo(analysisExpenseStackView.snp.centerY)
        }

        detailButton.snp.makeConstraints {
            $0.centerY.equalTo(analysisExpenseStackView.snp.centerY)
        }

        analysisExpenseEmptyView.snp.makeConstraints {
            $0.top.equalTo(analysisExpenseStackView.snp.bottom).offset(10)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(142)
        }

        analysisExpenseEmptyLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(24)
            $0.centerX.equalToSuperview()
        }

        analysisExpenseEmptyButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(24)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(48)
        }
    }

    // MARK: Event
}
