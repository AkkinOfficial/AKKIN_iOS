//
//  AnalysisExpenseDetailView.swift
//  AKKIN
//
//  Created by 박지윤 on 8/8/24.
//

import UIKit

final class AnalysisExpenseDetailView: BaseView {

    // MARK: UI Components
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

    // MARK: Properties
    var monthAnalysisList = MonthAnalysis.monthAnalysisList
    var totalExpense = 0
    var month = 0

    var planisEmpty = true

    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()

        setCollectionView()
        addSubview(monthAnalysisCollectionView)
    }

    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()

        let collectionViewHeight1 = 113 + 24 + 77 * monthAnalysisList.count
        let collectionViewHeight2 = 254 + 24 + 77 * monthAnalysisList.count

        monthAnalysisCollectionView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).inset(32)
            $0.horizontalEdges.equalToSuperview().inset(20)
            if !planisEmpty {
                $0.height.equalTo(collectionViewHeight1)
            } else {
                $0.height.equalTo(collectionViewHeight2)
            }
        }
    }

    // MARK: Data
    func getTotalExpense(monthAnaysisData: [MonthAnalysis]) {
        for monthAnaysis in monthAnaysisData {
            totalExpense += monthAnaysis.expense
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
        if planisEmpty {
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
                self.monthAnalysisList[0].month -= 1
                collectionView.reloadData()
            }
            header.tapNext = {
                self.monthAnalysisList[0].month += 1
                collectionView.reloadData()
            }

            return header
        } else {
            return UICollectionReusableView()
        }
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return monthAnalysisList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MonthAnalysisCollectionViewCell.identifier,
            for: indexPath) as? MonthAnalysisCollectionViewCell else {
            return UICollectionViewCell()
        }

        cell.setData(monthAnaysisData: monthAnalysisList[indexPath.row])
        cell.tapDetail = {
        }

        return cell
    }
}
