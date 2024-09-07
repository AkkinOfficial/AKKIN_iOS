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
            // left right hidden true
            // circle hidden false
            leftRectBackImageView.isHidden = true
            rightRectBackImageView.isHidden = true
            circleBackImageView.isHidden = false

        case .firstDate:
            // leftRect hidden true
            // circle, right hidden false
            leftRectBackImageView.isHidden = true
            circleBackImageView.isHidden = false
            rightRectBackImageView.isHidden = false

        case .middleDate:
            // circle hidden true
            // left, right hidden false
            circleBackImageView.isHidden = true
            leftRectBackImageView.isHidden = false
            rightRectBackImageView.isHidden = false

        case .lastDate:
            // rightRect hidden true
            // circle, left hidden false
            rightRectBackImageView.isHidden = true
            circleBackImageView.isHidden = false
            leftRectBackImageView.isHidden = false

        case .notSelected:
            // all hidden
            circleBackImageView.isHidden = true
            leftRectBackImageView.isHidden = true
            rightRectBackImageView.isHidden = true
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        circleBackImageView.isHidden = true
        leftRectBackImageView.isHidden = true
        rightRectBackImageView.isHidden = true
    }
}


