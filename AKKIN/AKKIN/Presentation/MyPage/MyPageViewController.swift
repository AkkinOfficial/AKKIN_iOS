//
//  MyPageViewController.swift
//  AKKIN
//
//  Created by 박지윤 on 8/8/24.
//

import UIKit

final class MyPageViewController: BaseViewController {

    // MARK: UI Components
    private let myPageView = MyPageView()

    // MARK: Environment
    private let router = BaseRouter()
    var nickname = ""

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        getUser()
        router.viewController = self

        setNavigationItem()
    }

    // MARK: Configuration
    override func configureSubviews() {
        view.addSubview(myPageView)

        //    myPageView.tapHomeWidgetSetting = { [weak self] in
        //    guard let self else { return }
        //    router.presentHomeWidgetSettingViewController()
        //  }

        myPageView.tapEdit = { [weak self] in
            guard let self else { return }
            myPageView.setNicknameEditMode()
        }

        myPageView.tapConfirm = { [self] nickname in
            let request = UserRequest(nickname: nickname)
            putUserNickname(request: request)
        }

        myPageView.tapAppInfo = { [weak self] url in
            guard let self else { return }
            router.presentSafariViewController(url: url)
        }

        myPageView.tapLogout = { [weak self] in
            guard let self else { return }
            presentAlert(
                title: "로그아웃하시겠어요?",
                message: nil,
                cancelButton: "취소",
                actionButton: "확인",
                style: .cancel,
                handler: { action in self.logout() }
            )
        }

        myPageView.tapWithdrawal = { [weak self] in
            guard let self else { return }
            presentAlert(
                title: "정말 탈퇴하시겠어요?",
                message: "이 동작은 취소할 수 없어요.",
                cancelButton: "취소",
                actionButton: "탈퇴하기",
                style: .destructive,
                handler: { action in self.withdrawal() }
            )
        }
    }

    // MARK: Layout
    override func makeConstraints() {
        myPageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    // MARK: Navigation Item
    private func setNavigationItem() {
        navigationController?.navigationBar.isHidden = true
    }

    private func setData(data: Users) {
        myPageView.setData(data: data)
    }
}

extension MyPageViewController {
    private func presentAlert(
        title: String,
        message: String?,
        cancelButton: String,
        actionButton: String,
        style: UIAlertAction.Style,
        handler: ((UIAlertAction) -> Void)?
    ) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert)
        
        let cancelButton = UIAlertAction(
            title: cancelButton,
            style: .default)
        let actionButton = UIAlertAction(
            title: actionButton,
            style: style,
            handler: handler)
        
        alertController.addAction(cancelButton)
        alertController.addAction(actionButton)
        
        present(alertController, animated: true)
    }
}

// MARK: Networking
extension MyPageViewController {
    private func logout() {
        print("logout")
    }

    private func withdrawal() {
        print("withdrawal")
    }
}

extension MyPageViewController {
    // MARK: Network
    private func getUser() {
        print("💸 getUser called")
        NetworkService.shared.users.getUser() { [self] result in
            switch result {
            case .success(let response):
                guard let data = response as? UsersResponse else { return }
                print("🎯 getUser success\n\(data)")
                nickname = data.body.nickname
                setData(data: data.body)
            case .requestErr(let errorResponse):
                dump(errorResponse)
                guard let data = errorResponse as? ErrorResponse else { return }
                print("🤖 \(data)")
            case .serverErr:
                print("serverErr")
            case .networkFail:
                print("networkFail")
            case .pathErr:
                print("pathErr")
            }
        }
    }

    private func putUserNickname(request: UserRequest) {
        print("💸 putUserNickname called")
        NetworkService.shared.users.putUserNickname(request: request){ [self] result in
            switch result {
            case .success(let response):
                guard let data = response as? UsersResponse else { return }
                print("🎯 putUserNickname success\n\(data)")
                nickname = data.body.nickname
                myPageView.setEditCompleteMode(data: data.body)
            case .requestErr(let errorResponse):
                dump(errorResponse)
                guard let data = errorResponse as? ErrorResponse else { return }
                print("🤖 \(data)")
            case .serverErr:
                print("serverErr")
            case .networkFail:
                print("networkFail")
            case .pathErr:
                print("pathErr")
            }
        }
    }
}

