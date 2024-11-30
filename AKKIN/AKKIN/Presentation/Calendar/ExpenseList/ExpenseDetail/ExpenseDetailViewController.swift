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
    init(data: ExpensesList) {
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
    var expenseData: ExpensesList

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
    func setData(data: ExpensesList) {
        let categoryImage = ExpensesList.mapCategoryImage(data.category)
        let categoryKorean = ExpensesList.mapCategory(data.category)

        expenseDetailView.categoryImageLabel.text = categoryImage
        expenseDetailView.infoLabel.text = categoryKorean
        expenseDetailView.titleLabel.text = data.content
        expenseDetailView.expenseLabel.text = data.amount.toPriceFormat + "원"
        expenseDetailView.memoLabel.text = "메모"
    }

    func presentActionSheet() {
        let actionSheet = UIAlertController(title: "상세 지출 내역", message: nil, preferredStyle: .actionSheet)

        let editAction = UIAlertAction(title: "수정", style: .default) { _ in
            print("수정")
        }

        let deleteAction = UIAlertAction(title: "삭제", style: .destructive) { [self] _ in
            presentDeleteConfirmation()
        }

        let cancelAction = UIAlertAction(title: "닫기", style: .cancel, handler: nil)

        actionSheet.addAction(editAction)
        actionSheet.addAction(deleteAction)
        actionSheet.addAction(cancelAction)

        self.present(actionSheet, animated: true, completion: nil)
    }

    func presentDeleteConfirmation() {
        let alert = UIAlertController(title: "지출 내역을 삭제하시겠어요?",
                                      message: "지출 내역을 삭제한 이후에는\n해당 내역을 복구할 수 없어요😢",
                                      preferredStyle: .alert)

        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        let confirmAction = UIAlertAction(title: "삭제", style: .destructive) { [self] _ in
            deleteExpenses(id: expenseData.id)
        }

        alert.addAction(cancelAction)
        alert.addAction(confirmAction)

        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: Networking
extension ExpenseDetailViewController {
//    private func patchExpenses(id: Int, request: ExpenseRequest) {
//        print("💸 patchExpenses called")
//        NetworkService.shared.calendar.patchExpenses(id: id, request: request) { [self] result in
//            switch result {
//            case .success(let response):
//                guard let data = response as? PatchExpensesResponse else { return }
//                print("🎯 patchExpenses success\n\(data)")
////                setData(date: date, data: data.body)
////                expensesData = data.body
//            case .requestErr(let errorResponse):
//                dump(errorResponse)
//                guard let data = errorResponse as? ErrorResponse else { return }
//                print("🤖 \(data)")
////                setEmptyData()
//                // TODO:
////                expensesData = Expenses.testExpenses
////                setData(date: date, data: Expenses.testExpenses)
//            case .serverErr:
//                print("serverErr")
//            case .networkFail:
//                print("networkFail")
//            case .pathErr:
//                print("pathErr")
//            }
//        }
//    }

    private func deleteExpenses(id: Int) {
        print("💸 deleteExpenses called")
        NetworkService.shared.calendar.deleteExpenses(id: id) { [self] result in
            switch result {
            case .success(let response):
                guard let data = response as? BlankDataResponse else { return }
                print("🎯 deleteExpenses success\n\(data)")
            case .requestErr(let errorResponse):
                dump(errorResponse)
                guard let data = errorResponse as? ErrorResponse else { return }
                print("🤖 \(data)")
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
