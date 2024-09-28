//
//  CustomToggleButton.swift
//  AKKIN
//
//  Created by 성현주 on 9/29/24.
//

import UIKit
import SnapKit

class CustomToggleButton: BaseView {

    // MARK: UI Components
    private let slider: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.4
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        view.layer.shadowRadius = 5
        return view
    }()

    private let leftLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "오늘"
        label.textAlignment = .center
        return label
    }()

    private let rightLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "기간 전체"
        label.textAlignment = .center
        return label
    }()

    private var isLeftSelected = true {
        didSet {
            updateLabelFonts()
        }
    }

    // MARK: Properties
    var tapToggle: (() -> Void)?

    override func configureSubviews() {
        super.configureSubviews()
        backgroundColor = .akkinBG
        layer.cornerRadius = 24

        addSubview(leftLabel)
        addSubview(rightLabel)
        addSubview(slider)
    }

    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()

        slider.snp.makeConstraints {
            $0.top.equalToSuperview().offset(4)
            $0.bottom.equalToSuperview().offset(-4)
            $0.width.equalToSuperview().multipliedBy(0.5).offset(-8)
            $0.leading.equalToSuperview().offset(4)
        }

        leftLabel.snp.makeConstraints {
            $0.leading.top.bottom.equalToSuperview()
            $0.trailing.equalTo(rightLabel.snp.leading)
        }

        rightLabel.snp.makeConstraints {
            $0.trailing.top.bottom.equalToSuperview()
            $0.width.equalTo(leftLabel)
        }

        bringSubviewToFront(leftLabel)
        bringSubviewToFront(rightLabel)

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(toggle))
        addGestureRecognizer(tapGesture)

        updateLabelFonts()
    }

    // MARK: Event
    @objc private func toggle() {
        isLeftSelected.toggle()
        sliderAnimation()
        tapToggle?()
    }

    // MARK: Methods
    private func updateLabelFonts() {
        leftLabel.font = isLeftSelected ? UIFont.boldSystemFont(ofSize: 16) : UIFont.systemFont(ofSize: 16)
        rightLabel.font = isLeftSelected ? UIFont.systemFont(ofSize: 16) : UIFont.boldSystemFont(ofSize: 16)
    }

    private func sliderAnimation(){
        UIView.animate(withDuration: 0.3) {
            self.slider.snp.remakeConstraints {
                $0.top.equalToSuperview().offset(4)
                $0.bottom.equalToSuperview().offset(-4)
                $0.width.equalToSuperview().multipliedBy(0.5).offset(-8)
                $0.leading.equalToSuperview().offset(self.isLeftSelected ? 4 : self.frame.width / 2 + 4)
            }
            self.layoutIfNeeded()
        }
    }
}
