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
            print("tap kebab button")
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
    func setData(data: ExpenseData) {
        expenseDetailView.categoryImageLabel.text = data.category.categoryImageString
        expenseDetailView.infoLabel.text = data.category.toString
        expenseDetailView.titleLabel.text = data.title
        expenseDetailView.expenseLabel.text = data.saving.toPriceFormat + "원"
        expenseDetailView.memoLabel.text = data.memo
    }
}
