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
    private let piggyBankView = PiggyBankDetailView()
    private let piggyBankAlert = UIAlertController(title: "저금통", message: "수정", preferredStyle: .actionSheet)
    private let piggyBankDeleteAlert = UIAlertController(title: "이 저금통을 삭제하시겠어요?", message: "저금통을 없애면\n해당 내용을 복구할 수 없어요🥺", preferredStyle: .alert)

    // MARK: Environment
    private let router = BaseRouter()

    // MARK: Life Cycle
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
        let delete = UIAlertAction(title: "삭제", style: .destructive){ action in
            print("삭제 버튼이 눌렸습니다.")
        }
        piggyBankDeleteAlert.addAction(cancel)
        piggyBankDeleteAlert.addAction(delete)

        present(piggyBankDeleteAlert, animated: true)
    }

    // MARK: Configuration
    override func configureSubviews() {
        view.addSubview(piggyBankView)

        configureView()
        piggyBankView.tapOutButton = { [weak self] in
            guard let self else { return }
            setpiggyBankAlert()
        }
        piggyBankView.backButton.tap = { [weak self] in
            guard let self else { return }
            router.popViewController()
        }
    }

    private func configureView() {
        let model = HomeModel.dailyDummy

        piggyBankView.progressView.totalAmount = CGFloat(model.availableAmount)
        piggyBankView.progressView.usedAmount = CGFloat(model.expenseAmount)
        piggyBankView.saveAmountLabel.text = "\(model.formattedExpenseAmount)원"
        piggyBankView.challengeAmountLabel.text = "\(model.formattedAvailableAmount)원"
        let percentage = trunc(CGFloat(model.expenseAmount) / CGFloat(model.availableAmount) * 100)
        piggyBankView.piggyBankScore.text = "\(percentage)% 달성"
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
