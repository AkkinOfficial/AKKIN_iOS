//
//  MyPageView.swift
//  AKKIN
//
//  Created by 박지윤 on 8/8/24.
//

import UIKit

final class MyPageView: BaseView {

    // MARK: UI Components
    private let navigationTitleLabel = UILabel().then {
        $0.text = "마이페이지"
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
    }

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
    }

    private let editButton = BaseButton().then {
        $0.setImage(AkkinButton.editButton, for: .normal)
        $0.isEnabled = true
        $0.backgroundColor = .clear
    }

    private let profileEditView = UIView()

    private let nicknameTextField = UITextField().then {
        $0.addLeftPadding(width: 5)
        $0.clearButtonMode = .always
        $0.setUnderLine()
    }

    private let confirmButton = BaseButton().then {
        $0.setTitle("완료", for: .normal)
        $0.setTitleColor(.akkinGreen, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 14)
        $0.isEnabled = true
        $0.backgroundColor = .akkinGreen.withAlphaComponent(0.2)
    }

    private let myPageTableView = UITableView(frame: .zero, style: .grouped).then {
        if #available(iOS 15, *) {
            $0.sectionHeaderTopPadding = 0
        }
        $0.isScrollEnabled = false
        $0.backgroundColor = .white
        $0.register(MyPageTableViewCell.self, forCellReuseIdentifier: MyPageTableViewCell.identifier)
        $0.register(MyPageTableViewHeader.self, forHeaderFooterViewReuseIdentifier: MyPageTableViewHeader.identifier)
        $0.register(MyPageTableViewFooter.self, forHeaderFooterViewReuseIdentifier: MyPageTableViewFooter.identifier)
        $0.separatorStyle = .none
    }

    // MARK: Properties
    private let headerTitle = ["앱 정보", "계정 관리"]
    private let setting = ["홈 위젯 설정"]
    private let appInfo = ["서비스 이용약관", "개인 정보 처리 방침", "오픈소스 사용정보"]
    private let account = ["로그아웃", "회원탈퇴"]
    private let url = [URLConst.termsURL,
                       URLConst.privacyPolicyURL,
                       URLConst.openSourceURL]

    var tapEdit: (() -> Void)?
    var tapConfirm: ((String) -> Void)?
//    var tapHomeWidgetSetting: (() -> Void)?
    var tapAppInfo: ((String) -> Void)?
    var tapLogout: (() -> Void)?
    var tapWithdrawal: (() -> Void)?

    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()
        setTableView()
        addButtonEvent()

        addSubview(navigationTitleLabel)
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

        navigationTitleLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).inset(8)
            $0.leading.equalToSuperview().inset(20)
        }

        profileView.snp.makeConstraints {
            $0.top.equalTo(navigationTitleLabel.snp.bottom).offset(15)
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
            $0.top.equalTo(navigationTitleLabel.snp.bottom).offset(95)
            $0.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
        }
    }

    // MARK: Event
    private func addButtonEvent() {
        editButton.addTarget(self, action: #selector(handleEditButton), for: .touchUpInside)
        confirmButton.addTarget(self, action: #selector(handleConfirmButton), for: .touchUpInside)
    }

//    private func handleHomeWidgetSettingEvent() {
//        tapHomeWidgetSetting?()
//    }

    @objc
    private func handleEditButton() {
        tapEdit?()
    }

    @objc
    private func handleConfirmButton() {
        guard let nickname = nicknameTextField.text else { return }
        tapConfirm?(nickname)
    }

    private func handleAppInfoEvent(url: String) {
        tapAppInfo?(url)
    }

    private func handleLogout() {
        tapLogout?()
    }

    private func handleWithdrawal() {
        tapWithdrawal?()
    }

    func setData(data: Users) {
        userNameLabel.text = data.nickname
    }
}

extension MyPageView {
    func setNicknameEditMode() {
        profileView.removeFromSuperview()
        addSubview(profileEditView)
        profileEditView.snp.makeConstraints {
            $0.top.equalTo(navigationTitleLabel.snp.bottom).offset(15)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(80)
        }

        profileEditView.addSubview(nicknameTextField)
        profileEditView.addSubview(confirmButton)

        nicknameTextField.placeholder = userNameLabel.text
    
        nicknameTextField.snp.makeConstraints {
            $0.centerY.leading.equalToSuperview()
            $0.trailing.equalTo(confirmButton.snp.leading).offset(-12)
            $0.height.equalTo(48)
        }

        confirmButton.snp.makeConstraints {
            $0.centerY.trailing.equalToSuperview()
            $0.height.equalTo(40)
            $0.width.equalTo(56)
        }
    }

    func setEditCompleteMode(data: Users) {
        profileEditView.removeFromSuperview()
        addSubview(profileView)

        profileView.snp.makeConstraints {
            $0.top.equalTo(navigationTitleLabel.snp.bottom).offset(15)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(80)
        }

        userNameLabel.text = data.nickname
    }
}

// MARK: TableView
extension MyPageView: UITableViewDelegate, UITableViewDataSource {
    private func setTableView() {
        myPageTableView.dataSource = self
        myPageTableView.delegate = self
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 3
        default:
            return 2
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = myPageTableView.dequeueReusableCell(withIdentifier: MyPageTableViewCell.identifier, for: indexPath) as? MyPageTableViewCell else { return UITableViewCell() }
        cell.settingSwitch.removeFromSuperview()

        switch indexPath.section {
        case 0:
            cell.contentLabel.text = appInfo[indexPath.row]
        case 1:
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

extension MyPageView {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            handleAppInfoEvent(url: url[indexPath.row])
        case 1:
            switch indexPath.row {
            case 0:
                handleLogout()
            case 1:
                handleWithdrawal()
            default:
                break
            }
        default:
            break
        }
    }
}
