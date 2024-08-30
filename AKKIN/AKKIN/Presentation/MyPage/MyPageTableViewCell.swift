//
//  MyPageTableViewCell.swift
//  AKKIN
//
//  Created by 박지윤 on 8/30/24.
//

import UIKit

final class MyPageTableViewCell: UITableViewCell {

    static let identifier = "MyPageTableViewCell"

    // MARK: UI Components
    private(set) var contentLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 16)
    }

    private(set) var detailButton = BaseButton().then {
        $0.setImage(AkkinButton.detailButton.withTintColor(.akkinGray6), for: .normal)
    }

    private(set) var settingSwitch = UISwitch()

    // MARK: init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier
)
        configureSubviews()
        makeConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Configuration
    private func configureSubviews() {
        addSubview(contentLabel)
        addSubview(detailButton)
        addSubview(settingSwitch)
    }

    // MARK: Layout
    private func makeConstraints() {
        contentLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(24)
            $0.centerY.equalToSuperview()
        }

        detailButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(20)
        }

        settingSwitch.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(24)
            $0.centerY.equalToSuperview()
        }
    }
}
