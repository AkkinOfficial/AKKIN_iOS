//
//  AnalysisExpenseView.swift
//  AKKIN
//
//  Created by 박지윤 on 8/22/24.
//

import UIKit

final class AnalysisExpenseView: BaseView {

    // MARK: UI Components
    private let mostCategoryStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 6
        $0.distribution = .fill
        $0.layer.cornerRadius = 16
        $0.backgroundColor = .white
        $0.isLayoutMarginsRelativeArrangement = true
        $0.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)
    }

    private let categoryImageLabel = UILabel().then {
        $0.text = "🍽️"
        $0.font = UIFont.systemFont(ofSize: 20)
    }

    private let categoryLabel = UILabel().then {
        $0.text = "식사에 가장 많이 썼어요"
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
    }

    private let emtpyView = UIView().then {
        $0.backgroundColor = .clear
    }

    private let detailButton = BaseButton().then {
        $0.setImage(AkkinButton.detailButton.withTintColor(.akkinGray6), for: .normal)
    }

    public lazy var monthAnalysisCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 72, height: 45)
        layout.sectionInset = UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
        layout.minimumLineSpacing = 16

        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        collectionView.isScrollEnabled = false
        collectionView.layer.cornerRadius = 16
        collectionView.register(MonthAnalysisCollectionViewCell.self,
                                forCellWithReuseIdentifier: MonthAnalysisCollectionViewCell.identifier)

        return collectionView
    }()

    // MARK: Properties
    var monthAnalysisList = MonthAnalysis.monthAnalysisList

    var tapDetailButton: (() -> Void)?

    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()
        setCollectionView()

        addSubview(mostCategoryStackView)
        addSubview(monthAnalysisCollectionView)

        mostCategoryStackView.addArrangedSubviews(categoryImageLabel,
                                                  categoryLabel,
                                                  emtpyView,
                                                  detailButton)

        detailButton.addTarget(self, action: #selector(handleDetailButtonEvent), for: .touchUpInside)
    }

    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()

        mostCategoryStackView.snp.makeConstraints {
            $0.top.width.equalToSuperview()
            $0.height.equalTo(56)
        }

        let collectionViewHeight = 45 * monthAnalysisList.count + 16 * (monthAnalysisList.count + 1)
        monthAnalysisCollectionView.snp.makeConstraints {
            $0.top.equalTo(mostCategoryStackView.snp.bottom).offset(8)
            $0.width.equalToSuperview()
            $0.height.equalTo(collectionViewHeight)
        }
    }

    // MARK: Event
    @objc private func handleDetailButtonEvent() {
        tapDetailButton?()
    }
}

// MARK: CollectionView
extension AnalysisExpenseView: UICollectionViewDelegate, UICollectionViewDataSource {
    private func setCollectionView() {
        monthAnalysisCollectionView.dataSource = self
        monthAnalysisCollectionView.delegate = self
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
        
        cell.detailButton.removeFromSuperview()
        cell.categoryExpenseLabel.snp.makeConstraints {
            $0.trailing.centerY.equalToSuperview()
        }
        
        cell.setData(data: monthAnalysisList[indexPath.row])
        
        return cell
    }
}
