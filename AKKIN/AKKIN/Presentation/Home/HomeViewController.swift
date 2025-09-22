//
//  HomeViewController.swift
//  AKKIN
//
//  Created by 성현주 on 9/15/24.
//

import UIKit

final class HomeViewController: BaseViewController {

    // MARK: UI Components
    var challengeId = 17
    private let homeView = HomeView()

    private let homeChallengeAlert = UIAlertController(title: "챌린지", message: "수정", preferredStyle: .actionSheet)
    private let homeChallengeDeleteAlert = UIAlertController(title: "챌린지를 삭제하시겠어요?", message: "챌린지와 관련된 모든 내용이 사라져요🥺", preferredStyle: .alert)

    // MARK: Environment
    private let router = BaseRouter()
    private let homeService = HomeService()

    // MARK: Properties
    private var currentType: String = "DAILY"
    private var homeModel: HomeModel?

    func setHomeChallengeAlert() {
        let confirm = UIAlertAction(title: "수정", style: .default){ action in
                print("확인 버튼이 눌렸습니다.")
            }
        let delete = UIAlertAction(title: "삭제", style: .destructive){ action in
            self.setpiggyBankDeleteAlert()
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

    func setpiggyBankDeleteAlert() {
        let cancel = UIAlertAction(title: "취소", style: .cancel){ action in
            print("취소 버튼이 눌렸습니다.")
            }
        let delete = UIAlertAction(title: "삭제", style: .destructive){ [self] action in
            deleteChallenge(challengeId: self.challengeId)
            print("삭제 버튼이 눌렸습니다.")
        }
        homeChallengeDeleteAlert.addAction(cancel)
        homeChallengeDeleteAlert.addAction(delete)

        present(homeChallengeDeleteAlert, animated: true)
    }

    func deleteChallenge(challengeId: Int) {
        print("💸 deleteChallenge called in HomeViewController")
        homeService.deleteChallenge(challengeId: challengeId) { [weak self] result in
            switch result {
            case .success(let response):
                guard response is HomeResponse else { return }
                print("🎯 deleteChallenge success in HomeViewController")
                NotificationCenter.default.post(name: NSNotification.Name("Challenge Deleted"), object: nil)

                self?.navigationController?.popToRootViewController(animated: true)
            case .requestErr(let errorResponse):
                dump(errorResponse)
                guard let data = errorResponse as? ErrorResponse else { return }
                print(data)
            case .serverErr:
                print("serverErr")
            case .networkFail:
                print("networkFail")
            case .pathErr:
                print("pathErr")
            }
        }
    }

    // MARK: Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        fetchExpenseSummary(for: currentType)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationItem()
        router.viewController = self
        configureView(for: currentType)
        //checkIfTimePassed()
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
            self.router.presentAddExpenseViewController()
        }

        homeView.toggleButton.tapToggle = { [weak self] in
            guard let self else { return }
            self.toggleType()
        }

        configureView(for: currentType)
    }

    private func toggleType() {
        currentType = (currentType == "DAILY") ? "ALL" : "DAILY"
        configureView(for: currentType)
        fetchExpenseSummary(for: currentType) //타입 변경시 api 호출
    }

    private func configureView(for type: String) {
        if let homeModel = homeModel {
            updateUI(with: homeModel, for: type)
        }
    }

    private let isDummyMode = true

    // MARK: API 호출 메서드
    private func fetchExpenseSummary(for type: String) {
        if isDummyMode {
            if let dummy = HomeModel.dummy(for: type.lowercased()) {
                self.homeModel = dummy
                self.updateUI(with: dummy, for: type)
                print("✅ Dummy Data Loaded for \(type)")
            } else {
                print("❌ Invalid dummy type")
            }
            return
        }

        homeService.getHomeExpensesSummary(type: type) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let data):
                if let summary = data as? HomeResponse {
                    let homeModel = HomeModel(
                        type: type,
                        savedAmount: summary.body.savedAmount,
                        expenseAmount: summary.body.expenseAmount,
                        availableAmount: summary.body.availableAmount)
                    self.homeModel = homeModel
                    self.updateUI(with: homeModel, for: type)
                } else {
                    print("Data decoding failed")
                }
            case .requestErr(let errorData):
                print("Request Error: \(errorData)")
            case .pathErr:
                print("Path Error")
            case .serverErr:
                print("Server Error")
            case .networkFail:
                print("Network Error")
            }
        }
    }

    // MARK: UI 업데이트 메서드
    private func updateUI(with model: HomeModel, for type: String) {
        homeView.progressView.totalAmount = CGFloat(model.availableAmount)
        homeView.progressView.usedAmount = CGFloat(model.expenseAmount)
        homeView.expenseAmountLabel.text = "\(model.formattedExpenseAmount)원"
        homeView.challengeAmountLabel.text = "\(model.formattedAvailableAmount)원"
        homeView.tapKebbab = { [weak self] in
            guard let self else { return }
            setHomeChallengeAlert()
        }
      
        let formattedSavedAmount = model.formattedSavedAmount

        let storedTime = UserDefaultHandler.dismissModalTime
        let currentTime = Date()
        if currentTime > storedTime {
            print("현재 시간이 저장된 시간을 지남. 지출 금액 업데이트 안함. == 어제의 savedamount 유지")
        } else {
            print("현재 시간이 저장된 시간을 지나지 않음. 지출 금액 업데이트")
            UserDefaultHandler.savedAmount = formattedSavedAmount
        }

        switch type {
        case "DAILY":
            homeView.progressView.setCenterImage(AkkinIcon.habitFilled)
            homeView.homeTitleLabel.setRangeAttributedText(
                title: "오늘 하루 아낀 금액 \n무려 \(formattedSavedAmount)원!",
                highlightedText: formattedSavedAmount,
                highlightedColor: UIColor.akkinGreen,
                highlightedFont: UIFont.systemFont(ofSize: 30, weight: .bold))
        case "ALL":
            homeView.progressView.setCenterImage(AkkinIcon.piggyBankFilled)
            homeView.homeTitleLabel.setRangeAttributedText(
                title: "그동안 아낀 금액 \n무려 \(formattedSavedAmount)원!",
                highlightedText: formattedSavedAmount,
                highlightedColor: UIColor.akkinGreen,
                highlightedFont: UIFont.systemFont(ofSize: 30, weight: .bold))
        default:
            break
        }

        print("\(type) type: Saved = \(model.savedAmount), Used = \(model.expenseAmount), Available = \(model.availableAmount)")
    }

    // MARK: 모달 관련 메서드
    private func checkIfTimePassed() {
        //테스트용
//        let testDate = Calendar.current.date(from: DateComponents(year: 2024, month: 11, day: 9))!
//        UserDefaultHandler.dismissModalTime = testDate

        let storedTime = UserDefaultHandler.dismissModalTime
        let currentTime = Date()
        if currentTime > storedTime {
            print("현재 시간이 저장된 시간을 지남. 모달 동작.")
            router.presentAlertViewController()
        } else {
            print("현재 시간이 저장된 시간을 지나지 않음. 동작 안함.")
        }

    }

    // MARK: Layout
    override func makeConstraints() {
        homeView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
