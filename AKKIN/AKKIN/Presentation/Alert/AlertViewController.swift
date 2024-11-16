//
//  AlertViewController.swift
//  AKKIN
//
//  Created by 성현주 on 11/8/24.
//

import Foundation
import UIKit

class AlertViewController: BaseViewController {

    // MARK: Properties
    private var alertType: AlertType?

    // MARK: UI Components
    private var alertView: AlertView?
    var component = Calendar.current.dateComponents([.year, .month, .day], from: Date())

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

    // MARK: Layout and Configuration
    override func configureSubviews() {
        guard let alertType = alertType else { return }
        alertView = AlertView(alertType: alertType)

        if let alertView = alertView {
            view.addSubview(alertView)
            alertView.tapRightButton = { [weak self] in
                guard let self = self else { return }
                self.router.dismissViewControllerNonAnimated()
                self.saveModalDismissTime()
            }

            if alertType == .piggyBankNonExistence {
                alertView.tapLeftButton = { [weak self] in
                    guard let self = self else { return }
                    self.router.dismissViewControllerNonAnimated()
                    self.saveModalDismissTime()
                }
            }
            bindMethod()
            updateUI()
            makeConstraints()
        }
    }

     override func makeConstraints() {
        alertView?.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func bindMethod(){
        switch(alertType) {
        case .piggyBankExistence:
            alertView?.tapRightButton = { [weak self] in
                guard let self = self else { return }
                self.router.dismissViewControllerNonAnimated()
                self.saveModalDismissTime()
            }

        case .piggyBankNonExistence:
            alertView?.tapRightButton = { [weak self] in
                guard let self = self else { return }
                self.router.dismissViewControllerNonAnimated()

                print("저금통 만들어야지")
                self.saveModalDismissTime()
            }
            alertView?.tapLeftButton = { [weak self] in
                guard let self = self else { return }
                self.router.dismissViewControllerNonAnimated()
                self.saveModalDismissTime()
            }

        case .none:
            print("none")
        }
    }

    private func updateUI() {
        guard let alertView = alertView, let alertType = alertType else { return }

        let savedAmount = "\(UserDefaultHandler.savedAmount)원"
        let fullText = alertType == .piggyBankExistence
            ? "어제 아낀 금액\n 무려 \(savedAmount)! \n 아낀 금액은 저금통에 담을게요!"
            : "어제 아낀 금액\n 무려 \(savedAmount)! \n 저금통을 만들까요?"

        let attributedString = NSMutableAttributedString(string: fullText)
        if let range = fullText.range(of: savedAmount) {
            let nsRange = NSRange(range, in: fullText)
            attributedString.addAttribute(.foregroundColor, value: UIColor.akkinGreen, range: nsRange)
        }
        alertView.emojiLabel?.text = "🙌🏻"
        alertView.textLabel?.attributedText = attributedString
    }

    private func saveModalDismissTime() {
        component.timeZone = TimeZone(abbreviation: "UTC")
        let dateWithoutTime = Calendar.current.date(from: component)!
        let nextDate = Calendar.current.date(byAdding: .day, value: 1, to: dateWithoutTime)
        UserDefaultHandler.dismissModalTime = nextDate ?? Date()
        print("다음 모달 호출 시간: \(UserDefaultHandler.dismissModalTime)")
    }

    // MARK: Network
    private func getPiggyBankSummary() {
        piggyBankService.getPiggyBankSummary { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                guard let data = response as? PiggyBankResponse else { return }
                self.alertType = data.body.isEmpty ? .piggyBankNonExistence : .piggyBankExistence
                DispatchQueue.main.async {
                    self.configureSubviews()
                }
            case .requestErr(let errorResponse):
                print(errorResponse)
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
