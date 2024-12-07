//
//  CalendarResponse.swift
//  AKKIN
//
//  Created by 박지윤 on 11/30/24.
//

struct ExpensesResponse: Codable {
    let status: Int
    let code: String
    let timestamp: String
    let body: Expenses
}

struct PatchExpensesResponse: Codable {
    let status: Int
    let code: String
    let timestamp: String
    let body: PatchExpenses
}

struct PatchExpenses: Codable {
    let savedAmount: Int
    let expenses: ExpensesList
}

struct Expenses: Codable {
    let savedAmount: Int
    let expenses: [ExpensesList]
}

struct ExpensesList: Codable {
    let id: Int
    let amount: Int
    let content: String
    let category: String
    let savedAmount: Int
}

extension Expenses {
    static let emtpyExpenses = Expenses(savedAmount: 0, expenses: [])
    
    static let testExpenses = Expenses(savedAmount: 15000,
                                       expenses: [ExpensesList(id: 0, amount: 1000, content: "테스트1", category: "MEAL", savedAmount: 1000),
                                                  ExpensesList(id: 1, amount: 14000, content: "테스트2", category: "CAFE_SNACK", savedAmount: 15000)])
}
