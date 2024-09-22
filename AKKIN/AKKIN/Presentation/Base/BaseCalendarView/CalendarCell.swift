//
//  CalendarCell.swift
//  AKKIN
//
//  Created by 성현주 on 9/7/24.
//

import FSCalendar
import UIKit

class CalendarCell: FSCalendarCell {

    var circleBackImageView = UIImageView()
    var leftRectBackImageView = UIImageView()
    var rightRectBackImageView = UIImageView()

    var expenseLabel = UILabel().then {
        $0.text = "+10,270"
        $0.textColor = .akkinGreen
        $0.font = UIFont.systemFont(ofSize: 10, weight: .medium)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setConfigure()
        setConstraints()
        settingImageView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setConfigure() {
        contentView.insertSubview(circleBackImageView, at: 0)
        contentView.insertSubview(leftRectBackImageView, at: 0)
        contentView.insertSubview(rightRectBackImageView, at: 0)
        contentView.insertSubview(expenseLabel, at: 0)
    }

    func setConstraints() {
        self.titleLabel.snp.makeConstraints { make in
            make.center.equalTo(contentView)
        }

        leftRectBackImageView.snp.makeConstraints { make in
            make.leading.equalTo(contentView)
            make.trailing.equalTo(contentView.snp.centerX)
            make.height.equalTo(32)
            make.centerY.equalTo(contentView)
        }

        circleBackImageView.snp.makeConstraints { make in
            make.center.equalTo(contentView)
            make.size.equalTo(32)
        }

        rightRectBackImageView.snp.makeConstraints { make in
            make.leading.equalTo(contentView.snp.centerX)
            make.trailing.equalTo(contentView)
            make.height.equalTo(32)
            make.centerY.equalTo(contentView)
        }

        expenseLabel.snp.makeConstraints {
            $0.centerX.equalTo(contentView)
            $0.top.equalTo(contentView.snp.bottom).inset(12)
        }
    }

    func settingImageView() {
        circleBackImageView.clipsToBounds = true
        circleBackImageView.layer.cornerRadius = 16

        [circleBackImageView].forEach { item in
            item.backgroundColor = .akkinGreen
        }
        [leftRectBackImageView, rightRectBackImageView].forEach { item in
            item.backgroundColor = .akkinGreen.withAlphaComponent(0.1)
        }
    }

    func updateBackImage(_ dateType: SelectedDateType) {
        switch dateType {
        case .singleDate:
            leftRectBackImageView.isHidden = true
            rightRectBackImageView.isHidden = true
            circleBackImageView.isHidden = false

        case .firstDate:
            leftRectBackImageView.isHidden = true
            circleBackImageView.isHidden = false
            rightRectBackImageView.isHidden = false

        case .middleDate:
            circleBackImageView.isHidden = true
            leftRectBackImageView.isHidden = false
            rightRectBackImageView.isHidden = false

        case .lastDate:
            rightRectBackImageView.isHidden = true
            circleBackImageView.isHidden = false
            leftRectBackImageView.isHidden = false

        case .notSelected:
            circleBackImageView.isHidden = true
            leftRectBackImageView.isHidden = true
            rightRectBackImageView.isHidden = true
        }
    }

    // TODO: 캘린더 뷰 데이터 연결
    func setBackImage() {
        
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        circleBackImageView.isHidden = true
        leftRectBackImageView.isHidden = true
        rightRectBackImageView.isHidden = true
    }
}


