//
//  HomeWidgetSettingView.swift
//  AKKIN
//
//  Created by 박지윤 on 8/30/24.
//

import UIKit

final class HomeWidgetSettingView: BaseView {

    // MARK: UI Components
    private let settingTableView = UITableView(frame: .zero, style: .grouped).then {
        if #available(iOS 15, *) {
            $0.sectionHeaderTopPadding = 0
        }
        $0.backgroundColor = .white
        $0.register(MyPageTableViewCell.self, forCellReuseIdentifier: MyPageTableViewCell.identifier)
        $0.register(MyPageTableViewHeader.self, forHeaderFooterViewReuseIdentifier: MyPageTableViewHeader.identifier)
        $0.register(MyPageTableViewFooter.self, forHeaderFooterViewReuseIdentifier: MyPageTableViewFooter.identifier)
        $0.separatorStyle = .none
    }

    // MARK: Properties
    private let headerTitle = ["홈 화면 설정", "금액 통계"]
    private let setting = ["홈 바로가기"]
    private let expenseAnalysis = ["하루 기준 남은 금액", "목표 기간 기준 남은 금액"]

    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()
        setTableView()

        addSubview(settingTableView)
    }

    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()

        settingTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    // MARK: Event
}

// MARK: TableView
extension HomeWidgetSettingView: UITableViewDelegate, UITableViewDataSource {
    private func setTableView() {
        settingTableView.dataSource = self
        settingTableView.delegate = self
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return 2
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = settingTableView.dequeueReusableCell(withIdentifier: MyPageTableViewCell.identifier, for: indexPath) as? MyPageTableViewCell else { return UITableViewCell() }
        cell.detailButton.removeFromSuperview()

        switch indexPath.section {
        case 0:
            cell.contentLabel.text = setting[indexPath.row]
        case 1:
            cell.contentLabel.text = expenseAnalysis[indexPath.row]
        default:
            break
        }

        cell.selectionStyle = .none

        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = settingTableView.dequeueReusableHeaderFooterView(withIdentifier: MyPageTableViewHeader.identifier) as? MyPageTableViewHeader else { return UITableViewHeaderFooterView() }
        header.titleLabel.text = headerTitle[section]

        return header
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 61
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let header = settingTableView.dequeueReusableHeaderFooterView(withIdentifier: MyPageTableViewFooter.identifier) as? MyPageTableViewFooter else { return UITableViewHeaderFooterView() }
        if section == 1 {
            header.dividerView.isHidden = true
        }

        return header
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 1 {
            return 0
        } else {
            return 28
        }
    }
}
