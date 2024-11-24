//
//  LoginViewController.swift
//  AKKIN
//
//  Created by 박지윤 on 2023/09/22.
//

import UIKit
import Moya
import AuthenticationServices

final class LoginViewController: BaseViewController {

    // MARK: UI Components
    private let loginView = LoginView()

    // MARK: Dependencies
    private let router = BaseRouter()
    private let authService = AuthService.shared

    // MARK: - State
    private var isLoggedIn = false

    // MARK: Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        router.viewController = self

        if let refreshToken = KeychainManager.shared.load(key: "refreshToken"), !refreshToken.isEmpty {
            print("🔑 RefreshToken found, attempting auto-login...")
            isLoggedIn = true
            router.presentTabBarViewController()
        } else {
            print("🔑 No refreshToken found, showing login screen.")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
    }

    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()

        view.addSubview(loginView)

        loginView.tapLogin = { [weak self] in
            self?.performAppleLogin()
        }
    }

    // MARK: Layout
    override func makeConstraints() {
        loginView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    // MARK: Network
    private func performAppleLogin() {
        guard !isLoggedIn else {
            print("🔁 Already logged in.")
            return
        }
        print("🚀 Starting Apple Login...")

        // AppleLoginManager를 사용해 로그인 수행
        AppleLoginManager.shared.performLogin { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.handleLoginSuccess(response: response)
            case .failure(let error):
                self.handleLoginFailure(error: error)
            }
        }
    }
    // MARK: - Helpers
    private func handleLoginSuccess(response: AppleLoginResponse) {
        // 토큰 유효성 검증
        guard !response.body.accessToken.isEmpty, !response.body.refreshToken.isEmpty else {
            handleLoginFailure(error: NSError(domain: "Login", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid tokens received from server"]))
            return
        }

        // 토큰 저장
        KeychainManager.shared.save(key: "accessToken", value: response.body.accessToken)
        KeychainManager.shared.save(key: "refreshToken", value: response.body.refreshToken)

        print("🎉 Login Successful! AccessToken: \(response.body.accessToken)")

        // 탭바 화면으로 이동
        DispatchQueue.main.async {
            self.router.presentTabBarViewController()
        }
    }

    private func handleLoginFailure(error: Error) {
        print("❌ Login Failed: \(error.localizedDescription)")

        // 에러 메시지 표시
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Login Failed", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true)
        }
    }
}
