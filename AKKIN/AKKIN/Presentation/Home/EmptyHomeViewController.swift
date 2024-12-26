//
//  EmptyHomeViewController.swift
//  AKKIN
//
//  Created by 박지윤 on 8/8/24.
//

import UIKit

final class EmptyHomeViewController: BaseViewController {

    // MARK: UI Components
    private let emptyHomeView = EmptyHomeView()

    // MARK: Environment
    private let router = BaseRouter()

    // MARK: Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationItem() 

        router.viewController = self
        //checkIfTimePassed()
    }

    // MARK: Configuration
    override func configureSubviews() {
        view.addSubview(emptyHomeView)

        //TODO: 라우터 수정
        emptyHomeView.tapExpense = { [weak self] in
            guard let self else { return }
            router.presentPlanExpenseViewController()
            //router.presentAlertViewController()
        }
    }

    // MARK: Layout
    override func makeConstraints() {
        emptyHomeView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }

    private func checkIfTimePassed() {
        let storedTime = UserDefaultHandler.dismissModalTime
        let currentTime = Date()
        if currentTime > storedTime {
            print("현재 시간이 저장된 시간을 지남. 모달 동작.")
            router.presentAlertViewController()
        } else {
            print("현재 시간이 저장된 시간을 지나지 않음. 동작 안함.")
        }

    }

    // MARK: Navigation Item
    private func setNavigationItem() {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

}
