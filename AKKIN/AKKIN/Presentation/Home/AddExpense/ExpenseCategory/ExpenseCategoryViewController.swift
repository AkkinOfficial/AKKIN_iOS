//
//  ExpenseCategoryViewController.swift
//  AKKIN
//
//  Created by 성현주 on 9/20/24.
//

import UIKit

protocol ExpenseCategoryViewControllerDelegate:
    AnyObject {
        func didSelectCategory(icon: String, category: String)
    }

final class ExpenseCategoryViewController: BaseViewController {

    // MARK: UI Components
    private let expenseCategoryView = ExpenseCategoryView()

    // MARK: Environment
    private let router = BaseRouter()

    // MARK: Properties
    weak var delegate: ExpenseCategoryViewControllerDelegate?
    var categories: [ExpenseCategory] = ExpenseCategory.getAllCategories()

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        router.viewController = self

        expenseCategoryView.collectionView.delegate = self
                expenseCategoryView.collectionView.dataSource = self
    }

    // MARK: Configuration
    override func configureSubviews() {
        view.addSubview(expenseCategoryView)
    }

    // MARK: Layout
    override func makeConstraints() {
        expenseCategoryView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension ExpenseCategoryViewController: UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! ExpenseCategoryCell

        let category = categories[indexPath.item]
        cell.iconImageView.text = category.icon
        cell.categoryLabel.text = category.name

        return cell
    }

    //TODO: 텍스트필드 업데이트 메서드 추가
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCategory = categories[indexPath.item]
        print("tap 카테고리: \(selectedCategory.name)")
        router.dismissViewController()
        self.delegate?.didSelectCategory(icon: selectedCategory.icon, category: selectedCategory.name)
    }
}

extension ExpenseCategoryViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 10
        let totalPadding = padding * 5 
        let availableWidth = collectionView.frame.width - totalPadding
        let widthPerItem = availableWidth / 4

        return CGSize(width: widthPerItem, height: 120)
    }
}
