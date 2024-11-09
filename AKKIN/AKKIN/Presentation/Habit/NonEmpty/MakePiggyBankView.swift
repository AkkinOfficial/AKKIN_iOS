//
//  MakePiggyBankView.swift
//  AKKIN
//
//  Created by 신종원 on 9/24/24.
//

import UIKit

final class MakePiggyBankView: BaseView {

    // MARK: UI Components
    var goalAmount = ""
    var currentAmount = ""

    let piggyBankImageLabel = UILabel().then {
        $0.text = "🍎"
        $0.font = UIFont.systemFont(ofSize: 24)
    }

    private let piggyBankStackView = UIView().then {
        $0.backgroundColor = .white
    }

    var piggyBankNameLabel = UILabel().then {
        $0.text = "아이패드 사기(D-5)"
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
    }

    var piggyBankAmountLabel = UILabel().then {
        $0.textColor = .akkinGray6
        $0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    }

    private let detailButton = BaseButton().then {
        $0.setImage(AkkinButton.detailButton.withTintColor(.akkinGray6), for: .normal)
        $0.isHidden = true
    }

    let circularProgressBar: CircularProgressView = {
        let view = CircularProgressView()
        var value = 0.5
        view.lineWidth = 5
        return view
    }()

    var piggyBankCompleteButton = BaseButton().then {
        $0.setGuideButton("금액 모으기 완료!")
        $0.isEnabled = true
        $0.isHidden = true
    }

    // MARK: Properties
    var tapDetailButton: (() -> Void)?
    var tapDetail: (() -> Void)?

    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()
        isUserInteractionEnabled = true
        backgroundColor = .white
        layer.cornerRadius = 16

        addSubview(piggyBankImageLabel)
        addSubview(piggyBankStackView)
        addSubview(circularProgressBar)
        addSubview(piggyBankCompleteButton)

        piggyBankStackView.addSubview(piggyBankNameLabel)
        piggyBankStackView.addSubview(piggyBankAmountLabel)


        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleDetailViewEvent(_:))) //
        addGestureRecognizer(tapGesture)
        detailButton.addTarget(self, action: #selector(handleDetailButtonEvent), for: .touchUpInside)
    }

    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()

        piggyBankImageLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
        piggyBankStackView.snp.makeConstraints {
            $0.leading.equalTo(piggyBankImageLabel.snp.trailing).offset(10)
            $0.height.equalTo(40)
            $0.width.equalTo(240)
            $0.centerY.equalToSuperview()
        }
        piggyBankNameLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.width.equalTo(240)
            $0.height.equalTo(19)
        }
        piggyBankAmountLabel.snp.makeConstraints {
            $0.top.equalTo(piggyBankNameLabel.snp.bottom).offset(4)
            $0.leading.equalToSuperview()
            $0.width.equalTo(240)
            $0.height.equalTo(19)
        }
        circularProgressBar.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.width.height.equalTo(28)
            $0.centerY.equalToSuperview()
        }
        piggyBankCompleteButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(24)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(48)
        }
        updateRateLabel()
    }

    // MARK: Event
    @objc private func handleDetailButtonEvent() {
        tapDetailButton?()
    }
    @objc private func handleDetailViewEvent(_ gesture: UITapGestureRecognizer) {
        tapDetail?()
    }

    private func updateRateLabel() {
        let attributedString = NSMutableAttributedString(string: "\(currentAmount)원 / \(goalAmount)원")
        attributedString.addAttribute(.foregroundColor, value: UIColor.akkinGreen, range: NSRange(location: 0, length: "\(currentAmount)원".count))
        attributedString.addAttribute(.foregroundColor, value: UIColor.black, range: NSRange(location: "\(currentAmount)원 ".count, length: "/ \(goalAmount)원".count))
        piggyBankAmountLabel.attributedText = attributedString
    }
}
