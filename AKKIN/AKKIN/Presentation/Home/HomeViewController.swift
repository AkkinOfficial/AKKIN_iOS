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

    private let homeChallengeAlert = UIAlertController(title: "챌린지", message: "수정", preferredStyle: .actionSheet)
    private let homeChallengeDeleteAlert = UIAlertController(title: "챌린지를 삭제하시겠어요?", message: "챌린지와 관련된 모든 내용이 사라져요🥺", preferredStyle: .alert)

    // MARK: Environment
    private let router = BaseRouter()

    // MARK: Properties
    private var currentType: String = "daily"

    func setHomeChallengeAlert() {
        let confirm = UIAlertAction(title: "수정", style: .default){ action in
                print("확인 버튼이 눌렸습니다.")
            }
        let delete = UIAlertAction(title: "삭제", style: .destructive){ action in
            self.homeChallengeDeleteAlert

            print("삭제 버튼이 눌렸습니다.")
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel){ cancel in
            print("취소 버튼이 눌렸습니다.")
        }
        homeChallengeAlert.addAction(confirm)
        homeChallengeAlert.addAction(delete)
        homeChallengeAlert.addAction(cancel)

        present(homeChallengeAlert, animated: true)
    }

//    func setpiggyBankDeleteAlert() {
//        let cancel = UIAlertAction(title: "취소", style: .cancel){ action in
//            print("취소 버튼이 눌렸습니다.")
//            }
//        let delete = UIAlertAction(title: "삭제", style: .destructive){ [self] action in
//            deleteChallage(challengeId: self.challengeId)
//            print("삭제 버튼이 눌렸습니다.")
//        }
//        homeChallengeDeleteAlert.addAction(cancel)
//        homeChallengeDeleteAlert.addAction(delete)
//
//        present(homeChallengeDeleteAlert, animated: true)
//    }
//    func deleteChallage(challegneId: Int) {
//        print("💸 deleteChallage called in HomeViewController")
//        AddChallengeService.deleteChallage(challengeId: challengeId) { [weak self] result in
//            switch result {
//            case .success(let response):
//                guard response is HomeDeleteResponse else { return }
//                print("🎯 deleteChallenge success in HomeViewController")
//                NotificationCenter.default.post(name: NSNotification.Name("Challenge Deleted"), object: nil)
//
//                self?.navigationController?.popToRootViewController(animated: true)
//            case .requestErr(let errorResponse):
//                dump(errorResponse)
//                guard let data = errorResponse as? ErrorResponse else { return }
//                print(data)
//            case .serverErr:
//                print("serverErr")
//            case .networkFail:
//                print("networkFail")
//            case .pathErr:
//                print("pathErr")
//            }
//        }
//    }

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
        homeView.tapKebbab = { [weak self] in
            guard let self else { return }
            setHomeChallengeAlert()
        }

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
