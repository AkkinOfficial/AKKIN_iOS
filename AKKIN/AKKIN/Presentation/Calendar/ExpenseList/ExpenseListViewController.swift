//
//  ExpenseListViewController.swift
//  AKKIN
//
//  Created by 박지윤 on 9/22/24.
//

import UIKit

final class ExpenseListViewController: BaseViewController {

    // MARK: UI Components
    private let expenseListView = ExpenseListView()

    public lazy var expenseListCollectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: createLayout()
        )
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(MonthAnalysisCollectionViewCell.self,
                                forCellWithReuseIdentifier: MonthAnalysisCollectionViewCell.identifier)

        return collectionView
    }()

    // MARK: Environment
    private let router = BaseRouter()

    // MARK: Properties
    var expensesData = Expenses.emtpyExpenses
    var date: String

    var date: String

    // MARK: Init
    init(date: String) {
        self.date = date
        super.init(nibName: nil, bundle: nil)

        getExpenses(date: date)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationItem()

        router.viewController = self
    }

    // MARK: Configuration
    override func configureSubviews() {
        view.addSubview(expenseListView)
        view.addSubview(expenseListCollectionView)

        expenseListView.tapBackButtonEvent = { [self] in
            router.popViewController()
        }

        expenseListView.tapAddButtonEvent = { [self] in
            print("tap add button")
        }

        expenseListView.tapPrevious = { [self] date in
            getExpenses(date: DateFormatter.formatDateToString(date, "yyyy-MM-dd"))
        }

        expenseListView.tapNext = { [self] date in
            getExpenses(date: DateFormatter.formatDateToString(date, "yyyy-MM-dd"))
        }
    }

    // MARK: Layout
    override func makeConstraints() {
        expenseListView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
        }

        expenseListCollectionView.snp.makeConstraints {
            $0.top.equalTo(expenseListView.snp.bottom)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview()
        }
    }

    // MARK: Navigation Item
    private func setNavigationItem() {
        navigationController?.isNavigationBarHidden = true
    }
}

// MARK: CollectionView
extension ExpenseListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { [weak self] (_, _) -> NSCollectionLayoutSection? in
            return self?.createSection()
        }
    }
    
    private func createSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .absolute(77))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(77))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .none
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        return section
    }
    
    private func setCollectionView() {
        expenseListCollectionView.dataSource = self
        expenseListCollectionView.delegate = self
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return expensesData.expenses.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MonthAnalysisCollectionViewCell.identifier,
            for: indexPath) as? MonthAnalysisCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.setExpenseListData(data: expensesData.expenses[indexPath.row])
        cell.tapDetail = {
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = expensesData.expenses[indexPath.row]
        router.presentExpenseDetailViewController(data: data)
    }
}

extension ExpenseListViewController {
    // MARK: Network
    private func getExpenses(date: String) {
        print("💸 getExpenses called")
        NetworkService.shared.calendar.getExpenses(date: date) { [self] result in
            switch result {
            case .success(let response):
                guard let data = response as? ExpensesResponse else { return }
                print("🎯 getExpenses success\n\(data)")
                expenseListView.setData(date: date, data: data.body)
                setCollectionView()
                expensesData = data.body
            case .requestErr(let errorResponse):
                dump(errorResponse)
                guard let data = errorResponse as? ErrorResponse else { return }
                print("🤖 \(data)")
//                setEmptyData()
                // TODO:
                expensesData = Expenses.testExpenses
                expenseListView.setData(date: date, data: Expenses.testExpenses)
                setCollectionView()
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

