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
        $0.text = "월별 지출 분석"
        $0.textColor = .akkinBlack2
        $0.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
    }

    private let addButton = BaseButton().then {
        $0.setImage(AkkinButton.addButton.withTintColor(.akkinBlack2), for: .normal)
        $0.isEnabled = true
        $0.backgroundColor = .clear
    }

    let monthAnalysisHeaderView = MonthAnalysisHeaderView()

    public lazy var monthAnalysisCollectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: createLayout()
        )
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(MonthAnalysisCollectionViewCell.self,
                                forCellWithReuseIdentifier: MonthAnalysisCollectionViewCell.identifier)

        return collectionView
    }()

    private let analysisExpenseDetailEmptyView = AnalysisExpenseDetailEmptyView()

    // MARK: Properties
    var analysis = AnalysisData.emptyAnalysisData
    var totalExpense = 0
    var month = 0

    var tapBackButtonEvent: (() -> Void)?
    var tapAddButtonEvent: (() -> Void)?
    var tapMonthButtonEvent: (() -> Void)?

    // TODO: Empty Case UI Test
    var challengeIsEmpty = false
    var analysisIsEmpty = false

    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()

        addSubview(backButton)
        addSubview(navigationTitleLabel)
        addSubview(addButton)

        addSubview(monthAnalysisHeaderView)
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
    }
    
    func setDynamicNonEmptyLayout() {
        let collectionViewHeight1 = 113 + 24 + 77 * analysis.element.count
        let collectionViewHeight2 = 254 + 24 + 77 * analysis.element.count

        monthAnalysisHeaderView.snp.makeConstraints {
            $0.top.equalTo(navigationTitleLabel.snp.bottom).offset(47)
            $0.horizontalEdges.equalToSuperview().inset(20)
            if challengeIsEmpty {
                $0.height.equalTo(278)
            } else {
                $0.height.equalTo(137)
            }
        }

        monthAnalysisCollectionView.snp.makeConstraints {
            $0.top.equalTo(monthAnalysisHeaderView.snp.bottom)
            $0.horizontalEdges.equalToSuperview().inset(20)
            if analysisIsEmpty {
                $0.height.equalTo(23)
            } else {
                $0.height.equalTo(collectionViewHeight2)
            }
        }
    }

    func setDynamicEmptyLayout() {
        monthAnalysisHeaderView.totalExpenseLabel.removeFromSuperview()
        monthAnalysisHeaderView.monthAnalysisView.removeFromSuperview()
        monthAnalysisHeaderView.planExpenseGuideView.removeFromSuperview()

        monthAnalysisHeaderView.snp.makeConstraints {
            $0.top.equalTo(navigationTitleLabel.snp.bottom).offset(47)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(23)
        }
    }

    // MARK: Data
    func setData(analysisData: AnalysisData, challengeData: ChallengeData) {
        print(challengeData.startDate)

        challengeIsEmpty = challengeData.startDate == 0 ? true : false
        analysisIsEmpty = analysisData.element.isEmpty ? true : false

        if analysisIsEmpty {
            setAnalysisEmptyView()
            setDynamicEmptyLayout()
        } else {
            setAnalysisEmptyView()
            setDynamicNonEmptyLayout()
            setCollectionView()
        }
        analysis = analysisData
        totalExpense = analysisData.totalAmount
    }

    private func setAnalysisEmptyView() {
        monthAnalysisCollectionView.removeFromSuperview()

        addSubview(analysisExpenseDetailEmptyView)

        analysisExpenseDetailEmptyView.snp.makeConstraints {
            $0.top.equalTo(monthAnalysisHeaderView.snp.bottom).offset(123)
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
        section.orthogonalScrollingBehavior = .none
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)

        return section
    }

    private func setCollectionView() {
        monthAnalysisCollectionView.dataSource = self
        monthAnalysisCollectionView.delegate = self
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
            return analysis.element.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MonthAnalysisCollectionViewCell.identifier,
            for: indexPath) as? MonthAnalysisCollectionViewCell else {
            return UICollectionViewCell()
        }

        cell.setData(data: analysis.element[indexPath.row])
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
