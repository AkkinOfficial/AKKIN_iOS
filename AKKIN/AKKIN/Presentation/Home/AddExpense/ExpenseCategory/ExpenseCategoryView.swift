//
//  ExpenseCategoryView.swift
//  AKKIN
//
//  Created by 성현주 on 9/20/24.
//

import UIKit

final class ExpenseCategoryView: BaseView {

    // MARK: UI Components
    lazy var categoryLabel = UILabel().then {
        $0.text = "소비 카테고리를 선택해주세요"
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
    }

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(ExpenseCategoryCell.self, forCellWithReuseIdentifier: "CategoryCell")

        return collectionView
    }()

    // MARK: Properties

    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()

        addSubview(categoryLabel)
        addSubview(collectionView)
    }

    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()

        categoryLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(26)
            $0.centerX.equalToSuperview()

        }
        collectionView.snp.makeConstraints {
            $0.top.equalTo(categoryLabel.snp.bottom).offset(26)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
    }

    // MARK: Event
}

