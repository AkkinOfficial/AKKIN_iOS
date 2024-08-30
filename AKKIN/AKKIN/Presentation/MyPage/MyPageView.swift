//
//  MyPageView.swift
//  AKKIN
//
//  Created by 박지윤 on 8/8/24.
//

import UIKit

final class MyPageView: BaseView {

    // MARK: UI Components
    private let profileView = UIView()

    private let userProfileBackgroundView = UIView().then {
        $0.backgroundColor = .akkinGray8
        $0.layer.cornerRadius = 16
    } 

    private let userProfileImageView = UIImageView().then {
        $0.image = AkkinIcon.habitFilled
    }

    private let userNameLabel = UILabel().then {
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        $0.text = "이름은최대여덟자"
    }

    private let editButton = BaseButton().then {
        $0.setImage(AkkinButton.editButton, for: .normal)
    }

    private let myPageTableView = UITableView(frame: .zero, style: .grouped).then {
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
    private let headerTitle = ["내 아낀거지", "앱 정보", "계정 관리"]
    private let setting = ["홈 위젯 설정"]
    private let appInfo = ["서비스 이용약관", "개인 정보 처리 방침", "오픈소스 사용정보"]
    private let account = ["로그아웃", "회원탈퇴"]

    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()
        setTableView()

        addSubview(profileView)
        profileView.addSubview(userProfileBackgroundView)
        userProfileBackgroundView.addSubview(userProfileImageView)
        profileView.addSubview(userNameLabel)
        profileView.addSubview(editButton)

        addSubview(myPageTableView)
    }

    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()

        profileView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(80)
        }

        userProfileBackgroundView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.height.width.equalTo(48)
        }

        userProfileImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(33)
        }

        userNameLabel.snp.makeConstraints {
            $0.leading.equalTo(userProfileBackgroundView.snp.trailing).offset(12)
            $0.centerY.equalToSuperview()
        }

        editButton.snp.makeConstraints {
            $0.leading.equalTo(userNameLabel.snp.trailing).offset(8)
            $0.centerY.equalToSuperview()
        }

        myPageTableView.snp.makeConstraints {
            $0.top.equalTo(profileView.snp.bottom)
            $0.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
        }
    }

    // MARK: Event
}

// MARK: TableView
extension MyPageView: UITableViewDelegate, UITableViewDataSource {
    private func setTableView() {
        myPageTableView.dataSource = self
        myPageTableView.delegate = self
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 3
        default:
            return 2
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = myPageTableView.dequeueReusableCell(withIdentifier: MyPageTableViewCell.identifier, for: indexPath) as? MyPageTableViewCell else { return UITableViewCell() }
        switch indexPath.section {
        case 0:
            cell.contentLabel.text = setting[indexPath.row]
        case 1:
            cell.contentLabel.text = appInfo[indexPath.row]
        case 2:
            cell.contentLabel.text = account[indexPath.row]
            cell.detailButton.isHidden = true
            switch indexPath.row {
            case 1:
                cell.contentLabel.font = UIFont.systemFont(ofSize: 14)
                cell.contentLabel.textColor = UIColor(red: 0.72, green: 0.72, blue: 0.72, alpha: 1)
            default:
                break
            }
        default:
            break
        }

        cell.selectionStyle = .none

        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = myPageTableView.dequeueReusableHeaderFooterView(withIdentifier: MyPageTableViewHeader.identifier) as? MyPageTableViewHeader else { return UITableViewHeaderFooterView() }
        header.titleLabel.text = headerTitle[section]

        return header
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 61
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let header = myPageTableView.dequeueReusableHeaderFooterView(withIdentifier: MyPageTableViewFooter.identifier) as? MyPageTableViewFooter else { return UITableViewHeaderFooterView() }
        if section == 2 {
            header.dividerView.isHidden = true
        }

        return header
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 2 {
            return 0
        } else {
            return 28
        }
    }
}

extension MyPageView {
    private func presentSafariView(url: String) {
        guard let url = URL(string: url) else { return }
//        let safariViewController = SFSafariViewController(url: url)
//        present(safariViewController, animated: true, completion: nil)
    }

//    private func presentAlert(
//        title: String,
//        message: String?,
//        cancelButton: String,
//        actionButton: String,
//        style: UIAlertAction.Style,
//        handler: ((UIAlertAction) -> Void)?
//    ) {
//        let alertController = UIAlertController(
//            title: title,
//            message: message,
//            preferredStyle: .alert)
//        
//        let cancelButton = UIAlertAction(
//            title: cancelButton,
//            style: .default)
//        let actionButton = UIAlertAction(
//            title: actionButton,
//            style: style,
//            handler: handler)
//
//        alertController.addAction(cancelButton)
//        alertController.addAction(actionButton)
//
//        present(alertController, animated: true)
//    }
}
