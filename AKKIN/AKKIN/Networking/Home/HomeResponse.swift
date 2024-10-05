//
//  HomeResponse.swift
//  AKKIN
//
//  Created by 성현주 on 10/6/24.
//

import Foundation

struct HomeResponse: Codable {
    let status: Int
    let code: String
    let timestamp: String
    let body: ExpenseSummary
}

struct ExpenseSummary: Codable {
    let planID: Int
    let savedAmount: Int
    let expenseAmount: Int
    let availableAmount: Int
}
