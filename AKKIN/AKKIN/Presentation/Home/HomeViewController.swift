//
//  HomeViewController.swift
//  AKKIN
//
//  Created by 성현주 on 9/15/24.
//

import UIKit

final class HomeViewController: BaseViewController {

    // MARK: UI Components
    private let homeView = HomeView()

    // MARK: Environment
    private let router = BaseRouter()

    // MARK: Properties
    private var currentType: String = "daily"

    // MARK: Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationItem()
        router.viewController = self
        //TODO: 네트워크 메서드 추가
        configureView(for: currentType)
    }

    // MARK: Navigation Item
    private func setNavigationItem() {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    // MARK: Configuration
    override func configureSubviews() {
        view.addSubview(homeView)

        homeView.tapAddExpense = { [weak self] in
            guard let self else { return }
            router.presentAddExpenseViewController()
        }

        homeView.toggleButton.tapToggle = { [weak self] in
            guard let self else { return }
            self.toggleType()
        }

        configureView(for: currentType)
    }

    private func toggleType() {
        currentType = (currentType == "daily") ? "all" : "daily"
        configureView(for: currentType)
    }

    private func configureView(for type: String) {
        guard let model = HomeModel.dummy(for: type) else { return }

        homeView.progressView.totalAmount = CGFloat(model.availableAmount)
        homeView.progressView.usedAmount = CGFloat(model.expenseAmount)
        homeView.expenseAmountLabel.text = "\(model.formattedExpenseAmount)원"
        homeView.challengeAmountLabel.text = "\(model.formattedAvailableAmount)원"

        switch type {
        case "daily":
            homeView.progressView.setCenterImage(AkkinIcon.habitFilled)
            homeView.homeTitleLabel.setRangeAttributedText(title: "오늘 하루 아낀 금액 \n무려 \(model.formattedSavedAmount)원!",
                                                           highlightedText: model.formattedSavedAmount,
                                                           highlightedColor: UIColor.akkinGreen,
                                                           highlightedFont: UIFont.systemFont(ofSize: 30, weight: .bold))
        case "all":
            homeView.progressView.setCenterImage(AkkinIcon.piggyBankFilled)
            homeView.homeTitleLabel.setRangeAttributedText(title: "그동안 아낀 금액 \n무려 \(model.formattedSavedAmount)원!",
                                                           highlightedText: model.formattedSavedAmount,
                                                           highlightedColor: UIColor.akkinGreen,
                                                           highlightedFont: UIFont.systemFont(ofSize: 30, weight: .bold))
        default:
            break
        }
        
        print("\(type) type: Saved = \(model.savedAmount), Used = \(model.expenseAmount), Available = \(model.availableAmount)")
    }

    // MARK: Layout
    override func makeConstraints() {
        homeView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
