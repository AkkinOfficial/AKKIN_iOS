//
//  HabitView.swift
//  AKKIN
//
//  Created by 박지윤 on 8/8/24.
//

import UIKit

final class HabitView: BaseView {
    
    // MARK: UI Components
    let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
    }
    private let mainLabel = UILabel().then {
        $0.text = "소비습관"
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
    }
    private let makePiggyBankStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 4
        $0.distribution = .fill
    }
    private let makePiggyBankLabel = UILabel().then {
        $0.text = "저금통"
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
    }
    var showMakePiggyBankView: Bool = true

    private let makePiggyBankEntireView = UIView()

    let makePiggyBankEmptyView = MakePiggyBankEmptyView()
    let makePiggyBankNonEmptyView = MakePiggyBankView()

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
    var tapDetailButton: (() -> Void)?

    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()

        backgroundColor = .akkinBG

        addSubview(scrollView)
        scrollView.addSubview(mainLabel)
        scrollView.addSubview(makePiggyBankEntireView)
        makePiggyBankEntireView.addSubview(makePiggyBankStackView)
        makePiggyBankStackView.addArrangedSubviews(makePiggyBankLabel)

        scrollView.addSubview(analysisExpenseEntireView)
        analysisExpenseEntireView.addSubview(analysisExpenseStackView)

        analysisExpenseStackView.addArrangedSubviews(analysisExpenseLabel, detailButton, emtpyView)

        detailButton.addTarget(self, action: #selector(handleDetailButtonEvent), for: .touchUpInside)
    }

    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()

        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        mainLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(15)
            $0.leading.equalToSuperview().inset(20)
        }

        makePiggyBankStackView.snp.makeConstraints {
            $0.top.equalTo(mainLabel.snp.bottom).offset(16)
            $0.leading.equalToSuperview().inset(24)
            $0.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(48)
        }
        makePiggyBankLabel.snp.makeConstraints {
            $0.centerY.equalTo(makePiggyBankStackView.snp.centerY)
        }

        updateView()

        analysisExpenseStackView.snp.makeConstraints {
            $0.top.equalTo(makePiggyBankEntireView.snp.bottom).offset(40)
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

    var viewState: ViewState = .empty {
        didSet {
            updateView()
        }
    }
    func updateView() {
        switch viewState {
        case .success:
            makePiggyBankEmptyView.removeFromSuperview()
            setMakePiggyBankNonEmtpyView()
        case .empty:
            setMakePiggyBankEmtpyView()
        case .zero: break
        }
    }

    func setMakePiggyBankNonEmtpyView() {
        makePiggyBankEntireView.addSubview(makePiggyBankNonEmptyView)

        makePiggyBankEntireView.snp.makeConstraints {
            $0.top.equalTo(mainLabel.snp.bottom).offset(16)
            $0.width.equalToSuperview()
            $0.height.equalTo(208)
        }

        makePiggyBankNonEmptyView.snp.makeConstraints {
            $0.top.equalTo(makePiggyBankStackView.snp.bottom).offset(8)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(self.makePiggyBankNonEmptyView.piggyBankCompleteButton.isHidden ? 72 : 130)
        }
    }

    func setMakePiggyBankEmtpyView() {
        makePiggyBankEntireView.addSubview(makePiggyBankEmptyView)

        makePiggyBankEntireView.snp.makeConstraints {
            $0.top.equalTo(mainLabel.snp.bottom).offset(16)
            $0.width.equalToSuperview()
            $0.height.equalTo(208)
        }

        makePiggyBankEmptyView.snp.makeConstraints {
            $0.top.equalTo(makePiggyBankStackView.snp.bottom).offset(8)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(152)
        }
    }

    func setAnalysisExpenseEmtpyView() {
        analysisExpenseEntireView.addSubview(analysisExpenseEmptyView)

        analysisExpenseEntireView.snp.makeConstraints {
            $0.top.equalTo(makePiggyBankEntireView.snp.bottom).offset(40)
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

    func setAnalysisExpenseNonEmtpyView(data: AnalysisData) {
        analysisExpenseEntireView.addSubview(analysisExpenseView)
        analysisExpenseView.setData(data: data)

        let collectionViewHeight = 45 * data.element.count + 16 * (data.element.count + 1)
        let analysisExpenseEntireViewHeight = 48 + 10 + collectionViewHeight + 64 + 40

        analysisExpenseEntireView.snp.makeConstraints {
            $0.top.equalTo(makePiggyBankEntireView.snp.bottom).offset(40)
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
    @objc private func handleDetailButtonEvent() {
        tapDetailButton?()
    }
}
