//
//  ExpenseListModel.swift
//  AKKIN
//
//  Created by 박지윤 on 9/23/24.
//

import Foundation

struct ExpenseListModel {
    var expenseList: [ExpenseData]
}

struct ExpenseData {
    var category: Category
    var title: String
    var memo: String?
    var saving: Int
    var total: Int
}
