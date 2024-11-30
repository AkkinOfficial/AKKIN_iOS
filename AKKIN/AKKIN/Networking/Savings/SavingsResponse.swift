//
//  SavingsResponse.swift
//  AKKIN
//
//  Created by 박지윤 on 10/12/24.
//

struct SavingsResponse: Codable {
    let status: Int
    let code: String
    let timestamp: String
    let body: [Savings]
}

struct SavingsDateResponse: Codable {
    let status: Int
    let code: String
    let timestamp: String
    let body: Savings
}

struct Savings: Codable {
    let id: Int
    let date: String
    let amount: Int
}

extension Savings {
    static let emptySavings: [Savings] = []

    static let testSavings = [Savings(id: 0, date: "2024-11-15", amount: 500000),
                               Savings(id: 0, date: "2024-11-27", amount: 35000),
                               Savings(id: 0, date: "2024-11-30", amount: 10000)]
}
