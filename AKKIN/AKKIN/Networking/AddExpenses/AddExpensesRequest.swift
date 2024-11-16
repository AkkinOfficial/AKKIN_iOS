//
//  AddExpensesRequest.swift
//  AKKIN
//
//  Created by 성현주 on 10/6/24.
//

import Foundation

struct AddExpenseRequest: Codable {
    let amount: Int
    let content: String
    let memo: String
    let date: String
    let category: String
}
