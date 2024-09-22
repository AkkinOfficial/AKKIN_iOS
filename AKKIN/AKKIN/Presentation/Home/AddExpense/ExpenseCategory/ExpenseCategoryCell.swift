//
//  ExpenseCategoryCell.swift
//  AKKIN
//
//  Created by 성현주 on 9/22/24.
//

import UIKit

class ExpenseCategoryCell: UICollectionViewCell {

    let backgroundCircleView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemGray6
        view.layer.cornerRadius = 32
        view.clipsToBounds = true
        return view
    }()

    let iconImageView: UILabel = {
        let imageLabel = UILabel()
        imageLabel.textAlignment = .center
        imageLabel.font = UIFont.systemFont(ofSize: 28)
        return imageLabel
    }()

    let categoryLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.addSubview(backgroundCircleView)
        backgroundCircleView.addSubview(iconImageView)
        contentView.addSubview(categoryLabel)

        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupConstraints() {
        backgroundCircleView.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(10)
            make.centerX.equalTo(contentView)
            make.width.height.equalTo(64)
        }

        iconImageView.snp.makeConstraints { make in
            make.center.equalTo(backgroundCircleView)
            make.width.height.equalTo(28)
        }

        categoryLabel.snp.makeConstraints { make in
            make.top.equalTo(backgroundCircleView.snp.bottom).offset(8)
            make.leading.trailing.equalTo(contentView).inset(5)
            make.bottom.equalTo(contentView).offset(-10)
        }
    }
}
