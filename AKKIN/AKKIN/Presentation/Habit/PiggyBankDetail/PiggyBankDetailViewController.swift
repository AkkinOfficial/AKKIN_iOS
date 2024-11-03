//
//  PiggyBankDetailViewController.swift
//  AKKIN
//
//  Created by 신종원 on 10/4/24.
//

import Foundation
import UIKit

final class PiggyBankDetailViewController: BaseViewController {

    // MARK: UI Components
    var bankId = 1
    private let piggyBankView = PiggyBankDetailView()
    private let piggyBankAlert = UIAlertController(title: "저금통", message: "수정", preferredStyle: .actionSheet)
    private let piggyBankDeleteAlert = UIAlertController(title: "이 저금통을 삭제하시겠어요?", message: "저금통을 없애면\n해당 내용을 복구할 수 없어요🥺", preferredStyle: .alert)
    private let piggyBankService = PiggyBankService()

    // MARK: Environment
    private let router = BaseRouter()

    // MARK: Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.frame = UIScreen.main.bounds
        view.backgroundColor = .white

        setNavigationItem()
        router.viewController = self
    }

    // MARK: Properties
    func setpiggyBankAlert() {
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
        piggyBankAlert.addAction(confirm)
        piggyBankAlert.addAction(delete)
        piggyBankAlert.addAction(cancel)

        present(piggyBankAlert, animated: true)
    }

    func setpiggyBankDeleteAlert() {
        let cancel = UIAlertAction(title: "취소", style: .cancel){ action in
            print("취소 버튼이 눌렸습니다.")
            }
        let delete = UIAlertAction(title: "삭제", style: .destructive){ [self] action in
            deletePiggyBank(bankId: self.bankId)
            print("삭제 버튼이 눌렸습니다.")
        }
        piggyBankDeleteAlert.addAction(cancel)
        piggyBankDeleteAlert.addAction(delete)

        present(piggyBankDeleteAlert, animated: true)
    }

    private func getPiggyBankDetailSummary() {
        print("💸 getPiggyBankDetailSummary called in PiggyBankDetailViewController")
        piggyBankService.getPiggyBankDetailSummary(bankId: bankId) { [weak self] result in
            switch result {
            case .success(let response):
                guard let data = response as? PiggyBankDetailResponse else { return }
                print("🎯 getPiggyBankDetailSummary success in PiggyBankDetailViewController")
                print("\(data.code)")
                var formattedGoalAmount: String {
                    return formattedAmount(data.body.goalAmount)
                }
                var formattedCurrentAmount: String {
                    return formattedAmount(data.body.currentAmount)
                }
                self?.piggyBankView.piggyBankScoreEmoji.text = data.body.emoji
                self?.piggyBankView.piggyBankName.text = data.body.name
                self?.piggyBankView.piggyBankDate.text = "\(data.body.startDate) ~ \(data.body.endDate)"
                let rate =  Double(data.body.achievementRate)/100
                self?.piggyBankView.piggyBankScore.text = "\(rate)%"
                self?.piggyBankView.progressView.progress = rate
                self?.piggyBankView.saveAmountLabel.text = "\(formattedCurrentAmount)원"
                self?.piggyBankView.challengeAmountLabel.text = "\(formattedGoalAmount)원"
                self?.bankId = data.body.id
                self?.piggyBankView.piggyBankMemo.text =  data.body.memo
                func formattedAmount(_ amount: Int) -> String {
                    return NumberFormatter.localizedString(from: NSNumber(value: amount), number: .decimal)
                }
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
    func deletePiggyBank(bankId: Int) {
        print("💸 deletePiggyBank called in PiggyBankDetailViewController")
        piggyBankService.deletePiggyBank(bankId: bankId) { [weak self] result in
            switch result {
            case .success(let response):
                guard response is PiggyBankDeleteResponse else { return }
                print("🎯 deletePiggyBank success in PiggyBankDetailViewController")
                NotificationCenter.default.post(name: NSNotification.Name("PiggyBankDeleted"), object: nil)

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

    // MARK: Configuration
    override func configureSubviews() {
        view.addSubview(piggyBankView)
        getPiggyBankDetailSummary()
        piggyBankView.tapOutButton = { [weak self] in
            guard let self else { return }
            setpiggyBankAlert()
        }
        piggyBankView.backButton.tap = { [weak self] in
            guard let self else { return }
            router.popViewController()
        }
    }

    // MARK: Layout
    override func makeConstraints() {
        piggyBankView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }

    // MARK: Navigation Item
    private func setNavigationItem() {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
}
