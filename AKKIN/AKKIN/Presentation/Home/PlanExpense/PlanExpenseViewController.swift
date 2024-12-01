//
//  PlanExpenseViewController.swift
//  AKKIN
//
//  Created by 박지윤 on 8/8/24.
//

import UIKit

final class PlanExpenseViewController: BaseViewController {

    // MARK: UI Components
    private let planExpenseView = PlanExpenseView()
    let setPeriodViewController = SetPeriodViewController(singleDate: false)

    // MARK: Environment
    private let router = BaseRouter()
    private let addChallengesService = AddChallengesService()

    // MARK: Properties
    private var startDate: String?
    private var endDate: String?
    private var duration: Int? {
        didSet {
            updateDailyAmount()
        }
    }
    private var amount: Int? {
        didSet {
            updateDailyAmount()
        }
    }

    // MARK: Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationItem()

        planExpenseView.editbudgetTextField = { [weak self] amountString in
            guard let self else { return }

            let cleanedAmountString = amountString.replacingOccurrences(of: ",", with: "")
            if let amount = Int(cleanedAmountString) {
                self.amount = amount
            } else {
                planExpenseView.helperLabel.text = "*유효한 금액을 입력해주세요."
            }
        }

        router.viewController = self
        setPeriodViewController.delegate = self
    }

    // MARK: Configuration
    override func configureSubviews() {
        view.addSubview(planExpenseView)
        hideKeyboard()

        planExpenseView.tapPeriodTextField = { [weak self] in
            guard let self else { return }
            router.presentSetPeriodViewController(setPeriodViewController)
        }

        planExpenseView.tapConfirmButton = { [weak self] in
            guard let self else { return }
            self.addExpense()
            router.popViewController()
        }

        planExpenseView.backButton.tap = { [weak self] in
            guard let self else { return }
            router.popViewController()
        }
    }

    // MARK: Helper Methods
    private func updateDailyAmount() {
        guard let amount = self.amount else {
            planExpenseView.helperLabel.text = "*유효한 금액을 입력해주세요."
            return
        }

        guard let duration = self.duration, duration > 0 else {
            planExpenseView.helperLabel.text = "*유효한 기간을 설정해주세요."
            return
        }

        let dailyAmount = amount / duration
        let numberFormatter: NumberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let result: String = numberFormatter.string(for: dailyAmount)!
        planExpenseView.helperLabel.text = "*하루 챌린지 금액을 \(result)원으로 설정할게요. \n챌린지 금액 / 기간을 한 값이에요."
    }

    // MARK: Layout
    override func makeConstraints() {
        planExpenseView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    // MARK: Navigation Item
    private func setNavigationItem() {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    private func addExpense() {
        guard let startDate = self.startDate,
              let endDate = self.endDate,
              let amount = self.amount else {
            return
        }

        let request = AddChallengesRequest(startDate: startDate, endDate: endDate, goalAmount: amount)

        addChallengesService.postChallenges(request: request) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let response):
                if let addChallengesResponse = response as? AddChellengesResponse {
                    print("challenges added successfully: \(addChallengesResponse)")
                }
            case .requestErr(let errorResponse):
                print("Request error: \(errorResponse)")
            case .serverErr:
                print("Server error")
            case .networkFail:
                print("Network failure")
            case .pathErr:
                print("Path error")
            }
        }
    }
}

extension PlanExpenseViewController: SetPeriodViewControllerDelegate {

    func didSelectDates(startDate: String, endDate: String, duration durationString: String) {
        self.startDate = startDate
        self.endDate = endDate 

        planExpenseView.periodTextField.text = "\(startDate) ~ \(endDate)"
        planExpenseView.periodTextField.addRightLabel(text: durationString)

        if let durationValue = Int(durationString.replacingOccurrences(of: "일", with: "")) {
            self.duration = durationValue
        } else {
            self.duration = nil
        }
    }
}
