//
//  AnalysisExpenseDetailView.swift
//  AKKIN
//
//  Created by 박지윤 on 8/8/24.
//

import UIKit

final class AnalysisExpenseDetailView: BaseView {

    // MARK: UI Components
    private let backButton = BaseButton().then {
        $0.setImage(AkkinButton.backButton.withTintColor(.akkinBlack2), for: .normal)
        $0.isEnabled = true
        $0.backgroundColor = .clear
    }

    private let navigationTitleLabel = UILabel().then {
        $0.text = "지출 내역"
        $0.textColor = .akkinBlack2
        $0.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
    }

    private let addButton = BaseButton().then {
        $0.setImage(AkkinButton.addButton.withTintColor(.akkinBlack2), for: .normal)
        $0.isEnabled = true
        $0.backgroundColor = .clear
    }

    public lazy var monthAnalysisCollectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: createLayout()
        )
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(MonthAnalysisCollectionViewCell.self,
                                forCellWithReuseIdentifier: MonthAnalysisCollectionViewCell.identifier)
        collectionView.register(MonthAnalysisCollectionViewHeader.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: MonthAnalysisCollectionViewHeader.identifier)

        return collectionView
    }()

    private let analysisExpenseDetailEmptyView = AnalysisExpenseDetailEmptyView()

    // MARK: Properties
    var monthAnalysisList = MonthAnalysis.monthAnalysisList
    var totalExpense = 0
    var month = 0

    var tapBackButtonEvent: (() -> Void)?
    var tapAddButtonEvent: (() -> Void)?
    var tapMonthButtonEvent: (() -> Void)?

    // TODO: Empty Case UI Test
    var planIsEmpty = false
    var analysisIsEmpty = false

    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()

        addSubview(backButton)
        addSubview(navigationTitleLabel)
        addSubview(addButton)

        setCollectionView()
        addSubview(monthAnalysisCollectionView)

        backButton.addTarget(self, action: #selector(handleBackButtonEvent), for: .touchUpInside)
        addButton.addTarget(self, action: #selector(handleAddButtonEvent), for: .touchUpInside)
    }

    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()

        backButton.snp.makeConstraints {
            $0.centerY.equalTo(navigationTitleLabel)
            $0.leading.equalToSuperview().inset(16)
        }

        navigationTitleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(safeAreaLayoutGuide).inset(15)
        }

        addButton.snp.makeConstraints {
            $0.centerY.equalTo(navigationTitleLabel)
            $0.trailing.equalToSuperview().inset(16)
        }

        let collectionViewHeight1 = 113 + 24 + 77 * monthAnalysisList.count
        let collectionViewHeight2 = 254 + 24 + 77 * monthAnalysisList.count

        monthAnalysisCollectionView.snp.makeConstraints {
            $0.top.equalTo(navigationTitleLabel.snp.bottom).offset(47)
            $0.horizontalEdges.equalToSuperview().inset(20)
            if analysisIsEmpty {
                $0.height.equalTo(23)
            } else if !planIsEmpty {
                $0.height.equalTo(collectionViewHeight1)
            } else {
                $0.height.equalTo(collectionViewHeight2)
            }
        }

        if analysisIsEmpty {
            setAnalysisEmptyView()
        }
    }

    // MARK: Data
    func getTotalExpense(monthAnaysisData: [MonthAnalysis]) {
        for monthAnaysis in monthAnaysisData {
            totalExpense += monthAnaysis.expense
        }
    }

    private func setAnalysisEmptyView() {
        addSubview(analysisExpenseDetailEmptyView)

        analysisExpenseDetailEmptyView.snp.makeConstraints {
            $0.top.equalTo(monthAnalysisCollectionView.snp.bottom).offset(123)
            $0.horizontalEdges.equalToSuperview().inset(63.5)
            $0.height.equalTo(250)
        }
    }
}

// MARK: CollectionView
extension AnalysisExpenseDetailView: UICollectionViewDelegate, UICollectionViewDataSource {
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
        section.boundarySupplementaryItems = [createSectionHeaderSupplementaryItem()]
        section.orthogonalScrollingBehavior = .none
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)

        return section
    }

    private func createSectionHeaderSupplementaryItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        var layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                heightDimension: .absolute(137))

        if analysisIsEmpty {
            layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                    heightDimension: .absolute(23))
        } else if planIsEmpty {
            layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                    heightDimension: .absolute(278))
        }

        let headerSupplementaryItem = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: layoutSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        headerSupplementaryItem.pinToVisibleBounds = true

        return headerSupplementaryItem
    }

    private func setCollectionView() {
        monthAnalysisCollectionView.dataSource = self
        monthAnalysisCollectionView.delegate = self
    }

    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            guard let header = monthAnalysisCollectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: MonthAnalysisCollectionViewHeader.identifier,
                for: indexPath) as? MonthAnalysisCollectionViewHeader else { return UICollectionReusableView() }
            header.setData(monthAnaysisData: monthAnalysisList, totalExpense: totalExpense)
            header.tapPrevious = {
                let currentYear = DataManager.shared.currentYear
                let currentMonth = DataManager.shared.currentMonth
                if currentMonth == 1 {
                    let updateYear = (currentYear ?? 0) - 1
                    let updateMonth = 12
                    DataManager.shared.updateDate(year: updateYear, month: updateMonth)
                } else {
                    let updateMonth = (currentMonth ?? 0) - 1
                    DataManager.shared.updateMonth(month: updateMonth)
                }
                collectionView.reloadData()
            }
            header.monthButton.addTarget(self, action: #selector(handleMonthButtonEvent), for: .touchUpInside)
            header.tapNext = {
                let currentYear = DataManager.shared.currentYear
                let currentMonth = DataManager.shared.currentMonth
                if currentMonth == 12 {
                    let updateYear = (currentYear ?? 0) + 1
                    let updateMonth = 1
                    DataManager.shared.updateDate(year: updateYear, month: updateMonth)
                } else {
                    let updateMonth = (currentMonth ?? 0) + 1
                    DataManager.shared.updateMonth(month: updateMonth)
                }
                collectionView.reloadData()
            }
            if analysisIsEmpty {
                header.totalExpenseLabel.removeFromSuperview()
                header.monthAnalysisView.removeFromSuperview()
                header.planExpenseGuideView.removeFromSuperview()
            }

            return header
        } else {
            return UICollectionReusableView()
        }
    }

    @objc func handleMonthButtonEvent() {
        tapMonthButtonEvent?()
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if analysisIsEmpty {
            monthAnalysisCollectionView.isScrollEnabled = false
            return 0
        } else {
            monthAnalysisCollectionView.isScrollEnabled = true
            return monthAnalysisList.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MonthAnalysisCollectionViewCell.identifier,
            for: indexPath) as? MonthAnalysisCollectionViewCell else {
            return UICollectionViewCell()
        }
//        cell.setData(data: monthAnalysisList[indexPath.row])
        cell.tapDetail = {
        }

        return cell
    }

    @objc func handleBackButtonEvent() {
        tapBackButtonEvent?()
    }

    @objc func handleAddButtonEvent() {
        tapAddButtonEvent?()
    }
}
