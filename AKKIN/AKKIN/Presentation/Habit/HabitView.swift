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

    private let piggyBankView = UIView()

    private let piggyBankStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fill
    }
    private let mainLabel = UILabel().then {
        $0.text = "소비습관"
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
    }

    private let piggyBankLabel = UILabel().then {
        $0.text = "저금통"
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
    }

    private let addButton = BaseButton().then {
        $0.setImage(AkkinButton.addButton, for: .normal)
        $0.isHidden = true
    }

    private let piggyBankEmptyView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 16
    }

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

    private let analysisExpenseEntireView = UIView()

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

    private let detailButton = UIButton().then {
        $0.setImage(AkkinButton.detailButton, for: .normal)
        $0.isEnabled = true
        $0.backgroundColor = .clear
    }

    private let emtpyView = UIView().then {
        $0.backgroundColor = .clear
    }

    private let analysisExpenseEmptyView = AnalysisExpenseEmptyView()
    let analysisExpenseView = AnalysisExpenseView()

    // MARK: Properties
    var reports = Reports.empty

    var tapDetailButton: (() -> Void)?
    var tapPiggyBankButton: (() -> Void)?

    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()

        backgroundColor = .akkinBG

        addSubview(scrollView)
        scrollView.addSubview(mainLabel)
        scrollView.addSubview(piggyBankView)
        piggyBankView.addSubview(piggyBankStackView)
        piggyBankView.addSubview(piggyBankEmptyView)

        piggyBankEmptyView.addSubview(piggyBankEmptyLabel)
        piggyBankEmptyView.addSubview(piggyBankEmptyButton)

        scrollView.addSubview(analysisExpenseEntireView)
        analysisExpenseEntireView.addSubview(analysisExpenseStackView)

        piggyBankStackView.addArrangedSubviews(piggyBankLabel, addButton)
        analysisExpenseStackView.addArrangedSubviews(analysisExpenseLabel, detailButton, emtpyView)

        piggyBankEmptyButton.addTarget(self, action: #selector(handleMakePiggyBankButtonEvent), for: .touchUpInside)
        detailButton.addTarget(self, action: #selector(handleDetailButtonEvent), for: .touchUpInside)
    }

    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()

        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        mainLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(20)
        }

        piggyBankView.snp.makeConstraints {
            $0.top.equalTo(mainLabel.snp.bottom).offset(31)
            $0.width.equalToSuperview()
            $0.height.equalTo(198)
        }

        piggyBankStackView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(24)
            $0.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(48)
        }

        piggyBankLabel.snp.makeConstraints {
            $0.centerY.equalTo(piggyBankStackView.snp.centerY)
        }

        addButton.snp.makeConstraints {
            $0.centerY.equalTo(piggyBankStackView.snp.centerY)
        }

        piggyBankEmptyView.snp.makeConstraints {
            $0.top.equalTo(piggyBankStackView.snp.bottom).offset(10)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(142)
        }

        piggyBankEmptyLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(24)
            $0.centerX.equalToSuperview()
        }

        piggyBankEmptyButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(24)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(48)
        }

        analysisExpenseStackView.snp.makeConstraints {
            $0.top.equalTo(piggyBankView.snp.bottom).offset(40)
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
    }

    func setAnalysisExpenseEmtpyView() {
        analysisExpenseEntireView.addSubview(analysisExpenseEmptyView)

        analysisExpenseEntireView.snp.makeConstraints {
            $0.top.equalTo(piggyBankView.snp.bottom).offset(40)
            $0.width.equalToSuperview()
            $0.height.equalTo(208)
            $0.bottom.equalToSuperview().inset(20)
        }

        analysisExpenseEmptyView.snp.makeConstraints {
            $0.top.equalTo(analysisExpenseStackView.snp.bottom).offset(10)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(142)
        }
    }

    func setAnalysisExpenseNonEmtpyView(data: Reports) {
        analysisExpenseEntireView.addSubview(analysisExpenseView)
        reports = data

        let collectionViewHeight = 45 * reports.categoryAnalysis.count + 16 * (reports.categoryAnalysis.count + 1)
        let analysisExpenseEntireViewHeight = 48 + 10 + collectionViewHeight + 64 + 40

        analysisExpenseEntireView.snp.makeConstraints {
            $0.top.equalTo(piggyBankView.snp.bottom).offset(40)
            $0.width.equalToSuperview()
            $0.height.equalTo(analysisExpenseEntireViewHeight)
            $0.bottom.equalToSuperview()
        }

        analysisExpenseView.snp.makeConstraints {
            $0.top.equalTo(analysisExpenseStackView.snp.bottom).offset(10)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(20)
        }
    }

    // MARK: Event
    @objc private func handleMakePiggyBankButtonEvent() {
        tapPiggyBankButton?()
    }
    @objc private func handleDetailButtonEvent() {
        tapDetailButton?()
    }
}
