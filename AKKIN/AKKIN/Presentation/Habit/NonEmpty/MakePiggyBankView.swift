//
//  MakePiggyBankView.swift
//  AKKIN
//
//  Created by 신종원 on 9/24/24.
//

import UIKit

final class MakePiggyBankView: BaseView {

    // MARK: UI Components
    let piggyBankImageLabel = UILabel().then {
        $0.text = "🍎"
        $0.font = UIFont.systemFont(ofSize: 24)
    }

    private let piggyBankStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 4
        $0.distribution = .fill
        $0.backgroundColor = .white
    }

    let piggyBankNameLabel = UILabel().then {
        $0.text = "아이패드 사기(D-5)"
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
    }

    let piggyBankAmountLabel = UILabel().then {
        $0.textColor = .akkinGray6
        $0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    }

    private let detailButton = BaseButton().then {
        $0.setImage(AkkinButton.detailButton.withTintColor(.akkinGray6), for: .normal)
        $0.isHidden = true
    }

    let circularProgressBar: CircularProgressView = {
        let view = CircularProgressView()
        view.value = 0.34
        return view
    }()

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

        piggyBankStackView.addArrangedSubviews(piggyBankNameLabel, piggyBankAmountLabel)


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
            $0.leading.equalToSuperview()
            $0.width.equalTo(240)
            $0.height.equalTo(19)
        }
        circularProgressBar.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.width.height.equalTo(28)
            $0.centerY.equalToSuperview()
        }
        updateMemoCountLabel()
    }

    // MARK: Event
    @objc private func handleDetailButtonEvent() {
        tapDetailButton?()
    }
    @objc private func handleDetailViewEvent(_ gesture: UITapGestureRecognizer) {
        tapDetail?()
    }

    private func updateMemoCountLabel() {
        let model = PiggyBankModel.dummy
        let goalAmount = model.formattedGoalAmount
        let currentAmount = model.formattedCurrentAmount

        let attributedString = NSMutableAttributedString(string: "\(currentAmount)원 / \(goalAmount)원")
        attributedString.addAttribute(.foregroundColor, value: UIColor.akkinGreen, range: NSRange(location: 0, length: "\(currentAmount)원".count))
        attributedString.addAttribute(.foregroundColor, value: UIColor.black, range: NSRange(location: "\(currentAmount)원 ".count, length: "/ \(goalAmount)원".count))
        piggyBankAmountLabel.attributedText = attributedString
    }
}
