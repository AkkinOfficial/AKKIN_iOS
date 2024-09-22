//
//  ExpenseCategoryModel.swift
//  AKKIN
//
//  Created by 성현주 on 9/22/24.
//

import UIKit

struct ExpenseCategory {
    let icon: UIImage
    let name: String

    static func getAllCategories() -> [ExpenseCategory] {
        return [
            ExpenseCategory(icon: UIImage(systemName: "fork.knife")!, name: "식사"),
            ExpenseCategory(icon: UIImage(systemName: "cup.and.saucer")!, name: "카페/간식"),
            ExpenseCategory(icon: UIImage(systemName: "mug")!, name: "술/유흥"),
            ExpenseCategory(icon: UIImage(systemName: "cart")!, name: "편의점"),
            ExpenseCategory(icon: UIImage(systemName: "tshirt")!, name: "의류"),
            ExpenseCategory(icon: UIImage(systemName: "drop")!, name: "미용"),
            ExpenseCategory(icon: UIImage(systemName: "music.note")!, name: "문화/취미"),
            ExpenseCategory(icon: UIImage(systemName: "bag")!, name: "생활"),
            ExpenseCategory(icon: UIImage(systemName: "airplane")!, name: "여행/숙박"),
            ExpenseCategory(icon: UIImage(systemName: "bus")!, name: "교통"),
            ExpenseCategory(icon: UIImage(systemName: "cross")!, name: "의료/건강"),
            ExpenseCategory(icon: UIImage(systemName: "graduationcap")!, name: "교육"),
            ExpenseCategory(icon: UIImage(systemName: "phone")!, name: "통신"),
            ExpenseCategory(icon: UIImage(systemName: "person.2")!, name: "회비"),
            ExpenseCategory(icon: UIImage(systemName: "envelope")!, name: "경조사"),
            ExpenseCategory(icon: UIImage(systemName: "ellipsis.bubble")!, name: "기타")
        ]
    }
}

