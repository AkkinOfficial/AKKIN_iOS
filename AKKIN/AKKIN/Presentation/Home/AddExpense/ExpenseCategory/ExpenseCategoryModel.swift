//
//  ExpenseCategoryModel.swift
//  AKKIN
//
//  Created by 성현주 on 9/22/24.
//

import UIKit

struct ExpenseCategory {
    let icon: String
    let name: String

    static func getAllCategories() -> [ExpenseCategory] {
        return [
            ExpenseCategory(icon: "🍽️", name: "식사"),
            ExpenseCategory(icon: "☕", name: "카페/간식"),
            ExpenseCategory(icon: "🍻", name: "술/유흥"),
            ExpenseCategory(icon: "🏪", name: "편의점"),
            ExpenseCategory(icon: "👕", name: "의류"),
            ExpenseCategory(icon: "🛁", name: "미용"),
            ExpenseCategory(icon: "🎶", name: "문화/취미"),
            ExpenseCategory(icon: "🛒", name: "생활"),
            ExpenseCategory(icon: "✈️", name: "여행/숙박"),
            ExpenseCategory(icon: "🚃", name: "교통"),
            ExpenseCategory(icon: "🏥", name: "의료/건강"),
            ExpenseCategory(icon: "🎓", name: "교육"),
            ExpenseCategory(icon: "📱", name: "통신"),
            ExpenseCategory(icon: "👨‍👧‍👦", name: "회비"),
            ExpenseCategory(icon: "✉️", name: "경조사"),
            ExpenseCategory(icon: "💬", name: "기타")
        ]
    }
}

