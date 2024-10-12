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
    var calendarModel = CalendarModel(month: 9, day: 23, monthSaving: 40940, monthRemaining: 470150)
    var expenseListModel = ExpenseListModel(expenseList:
                                            [ExpenseData(category: .cafe, title: "아메리카노+휘낭시에", saving: 7500, total: 8190),
                                             ExpenseData(category: .dining, title: "히레카츠+음료수", memo: "친구 만나서 파스타 냠냠", saving: 19000, total: 27190),
                                             ExpenseData(category: .traffic, title: "경기도 버스", saving: 2400, total: 29590),
                                             ExpenseData(category: .hobby, title: "영화", saving: 15000, total: 44590)]
    )

    var date: String

    // MARK: Init
    init(date: String) {
        self.date = date
        super.init(nibName: nil, bundle: nil)

        getSavingsDate(date: date)
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

    // MARK: Data
    func setData(data: Savings) {
//        expenseListView.dateButton.setTitle(month + " " + day, for: .normal)
        expenseListView.dateButton.setUnderline()
        expenseListView.dateButton.isEnabled = true
        expenseListView.dateButton.backgroundColor = .clear

        let daySaving = String(data.amount)
        expenseListView.savingLabel.text = "아낀 금액: " + daySaving + " 원"
        expenseListView.savingLabel.setColor(targetString: daySaving, color: .akkinGreen)

        setCollectionView()
    }

    func setEmptyData() {
        expenseListView.savingLabel.text = "아낀 금액: 0 원"
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
        return expenseListModel.expenseList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MonthAnalysisCollectionViewCell.identifier,
            for: indexPath) as? MonthAnalysisCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.setExpenseListData(data: expenseListModel.expenseList[indexPath.row])
        cell.tapDetail = {
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = expenseListModel.expenseList[indexPath.row]
        router.presentExpenseDetailViewController(data: data)
    }
}

extension ExpenseListViewController {
    // MARK: Network
    private func getSavingsDate(date: String) {
        print("💸 getSavings called")
        NetworkService.shared.savings.getSavingsDate(date: date) { [self] result in
            switch result {
            case .success(let response):
                guard let data = response as? SavingsDateResponse else { return }
                print("🎯 getSavingsDate success\n\(data)")
                setData(data: data.body)
            case .requestErr(let errorResponse):
                dump(errorResponse)
                guard let data = errorResponse as? ErrorResponse else { return }
                print("🤖 \(data)")
                setEmptyData()
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

