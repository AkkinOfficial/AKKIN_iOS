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
    let body: Savings
}

struct Savings: Codable {
    let id: Int
    let date: String
    let amount: Int
}
