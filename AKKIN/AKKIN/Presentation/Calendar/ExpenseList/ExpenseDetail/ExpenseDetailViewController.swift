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
    func setData(data: ExpensesList) {
        let categoryImage = ExpensesList.mapCategoryImage(data.category)
        let categoryKorean = ExpensesList.mapCategory(data.category)

        expenseDetailView.categoryImageLabel.text = categoryImage
        expenseDetailView.infoLabel.text = categoryKorean
        expenseDetailView.titleLabel.text = data.content
        expenseDetailView.expenseLabel.text = data.amount.toPriceFormat + "원"
        expenseDetailView.memoLabel.text = "메모"
    }
}
