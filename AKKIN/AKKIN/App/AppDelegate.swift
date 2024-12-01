//
//  AppDelegate.swift
//  AKKIN
//
//  Created by MK-Mac-413 on 2023/09/04.
//

import UIKit
import KakaoSDKCommon


@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if AppLaunchManager.isFirstLaunch() {
            KeychainManager.shared.resetKeychain()
        }
        
        // NotificationCenter에서 로그아웃 요청 수신
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleLogoutNotification),
            name: .didRequireLogin,
            object: nil
        )
        return true
    }
    @objc private func handleLogoutNotification() {
        KeychainManager.shared.resetKeychain()

        DispatchQueue.main.async {
            if let window = UIApplication.shared.windows.first {
                let loginVC = LoginViewController()
                loginVC.modalPresentationStyle = .fullScreen
                window.rootViewController = loginVC
                window.makeKeyAndVisible()
            }
        }
    }

    func applicationWillTerminate(_ application: UIApplication) {
        NotificationCenter.default.removeObserver(self, name: .didRequireLogin, object: nil)
    }
}


