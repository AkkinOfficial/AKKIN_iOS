//
//  MyPageTableViewFooter.swift
//  AKKIN
//
//  Created by 박지윤 on 8/30/24.
//

import UIKit

final class MyPageTableViewFooter: UITableViewHeaderFooterView {

    static let identifier = "MyPageTableViewFooter"

    // MARK: UI Components
    private(set) var dividerView = UIView().then {
        $0.backgroundColor = .akkinGray8
    }

    // MARK: init
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        configureSubviews()
        makeConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Configuration
    private func configureSubviews() {
        contentView.addSubview(dividerView)
    }

    // MARK: Layout
    private func makeConstraints() {
        dividerView.snp.makeConstraints {
            $0.bottom.horizontalEdges.equalToSuperview()
            $0.height.equalTo(12)
        }
    }
}
