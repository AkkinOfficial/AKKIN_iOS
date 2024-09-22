//
//  ExpenseDetailViewController.swift
//  AKKIN
//
//  Created by 박지윤 on 9/22/24.
//

import UIKit

final class ExpenseDetailViewController: BaseViewController {

    // MARK: UI Components
    private let expenseDetailView = ExpenseDetailView()

    // MARK: Environment
    private let router = BaseRouter()

    // MARK: Init
    init(data: ExpenseData) {
        self.expenseData = data
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setNavigationItem()
        setData(data: expenseData)
        router.viewController = self
    }

    // MARK: Properties
    var expenseData: ExpenseData

    // MARK: Configuration
    override func configureSubviews() {
        view.addSubview(expenseDetailView)

        expenseDetailView.tapBackButtonEvent = { [self] in
            router.popViewController()
        }

        expenseDetailView.tapKebabButtonEvent = { [self] in
            presentActionSheet()
        }
    }

    // MARK: Layout
    override func makeConstraints() {
        expenseDetailView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    // MARK: Navigation Item
    private func setNavigationItem() {
        navigationController?.isNavigationBarHidden = true
    }

    // MARK: Data
    private func setData(data: ExpenseData) {
        expenseDetailView.categoryImageLabel.text = data.category.categoryImageString
        expenseDetailView.infoLabel.text = data.category.toString
        expenseDetailView.titleLabel.text = data.title
        expenseDetailView.expenseLabel.text = data.saving.toPriceFormat + "원"
        expenseDetailView.memoLabel.text = data.memo
    }

    // MARK: ActionSheet & Alert
    private func presentActionSheet() {
        let actionSheet = UIAlertController(title: "상세 지출 내역", message: nil, preferredStyle: .actionSheet)

        actionSheet.addAction(UIAlertAction(title: "수정", style: .default, handler: { _ in
            print("수정")
            // router.presentEditViewController()
        }))
        actionSheet.addAction(UIAlertAction(title: "삭제", style: .destructive, handler: { _ in
            self.presentAlert()
        }))

        actionSheet.addAction(UIAlertAction(title: "닫기", style: .cancel, handler: nil))

        self.present(actionSheet, animated: true, completion: nil)
    }

    private func presentAlert() {
        let alert = UIAlertController(title: "지출 내역을 삭제하시겠어요?", message: "지출 내역을 삭제한 이후에는\n해당 내역을 복구할 수 없어요🥺", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "취소", style: .default, handler: { _ in  }))
        alert.addAction(UIAlertAction(title: "삭제", style: .destructive, handler: { _ in
            self.deleteExpenseData()
        }))

        self.present(alert, animated: true, completion: nil)
    }

    // MARK: Networking
    private func deleteExpenseData() {
        print("삭제")
    }
}
