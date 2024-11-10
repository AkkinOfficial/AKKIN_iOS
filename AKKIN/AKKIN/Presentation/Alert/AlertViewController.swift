//
//  AlertViewController.swift
//  AKKIN
//
//  Created by 성현주 on 11/8/24.
//

import Foundation
import UIKit

class AlertViewController: BaseViewController {

    // MARK:  Properties
    private var alertType: AlertType

    // MARK: Initializer
    init(alertType: AlertType) {
        self.alertType = alertType
        self.alertView = AlertView(alertType: alertType)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: UI Components
    private let alertView: AlertView

    // MARK: Environment
    private let router = BaseRouter()
    private let piggyBankService = PiggyBankService()


    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black.withAlphaComponent(0.2)
        router.viewController = self
        getPiggyBankSummary()
    }

    // MARK: Configuration
    override func configureSubviews() {
        view.addSubview(alertView)

        alertView.tapRightButton = { [weak self] in
            guard let self else { return }
            router.dismissViewControllerNonAnimated()
        }

        updateUI()
    }

    // MARK: Layout
    override func makeConstraints() {
        alertView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    private func updateUI() {
        switch alertType {
        case .piggyBankExistence:
            alertView.emojiLabel?.text = "🙌🏻"
            let savedAmount = "\(UserDefaultHandler.savedAmount)원"
            let fullText = "어제 아낀 금액\n 무려 \(savedAmount)! \n 아낀 금액은 저금통에 담을게요!"
            let attributedString = NSMutableAttributedString(string: fullText)

            if let range = fullText.range(of: savedAmount) {
                let nsRange = NSRange(range, in: fullText)
                attributedString.addAttribute(.foregroundColor, value: UIColor.akkinGreen, range: nsRange)
            }

            alertView.textLabel?.attributedText = attributedString

        case .piggyBankNonExistence:
            alertView.emojiLabel?.text = "🙌🏻"
            let savedAmount = "\(UserDefaultHandler.savedAmount)원"
            let fullText = "어제 아낀 금액\n 무려 \(savedAmount)! \n 저금통을 만들까요?"
            let attributedString = NSMutableAttributedString(string: fullText)

            if let range = fullText.range(of: savedAmount) {
                let nsRange = NSRange(range, in: fullText)
                attributedString.addAttribute(.foregroundColor, value: UIColor.akkinGreen, range: nsRange)
            }

            alertView.textLabel?.attributedText = attributedString
        }
    }

    // MARK: Network
    private func getPiggyBankSummary() {
        print("💸 getPiggyBank called in HabitViewController")
        piggyBankService.getPiggyBankSummary { [weak self] result in
            switch result {
            case .success(let response):
                guard let data = response as? PiggyBankResponse else { return }
                print("🎯 getPiggyBank success in HabitViewController")
                print("\(data.code)")
                self?.alertType = .piggyBankExistence

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
}
