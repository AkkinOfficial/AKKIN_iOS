//
//  PiggyBankResponse.swift
//  AKKIN
//
//  Created by 신종원 on 10/6/24.
//

import Foundation

struct PiggyBankResponse: Codable {
    let status: Int
    let code: String
    let timestamp: String
    let body: [PiggyBankSummary]
}

struct PiggyBankDetailResponse: Codable {
    let status: Int
    let code: String
    let timestamp: String
    let body: PiggyBankDetailSummary
}

struct PiggyBankSummary: Codable {
    let id: Int
    let name: String
    let dueDates: Int
    let goalAmount: Int
    let currentAmount: Int
    let achievementRate: Int
    let emoji: String
}

struct PiggyBankDetailSummary: Codable {
    let id: Int
    let name: String
    let memo: String
    let startDate: String
    let endDate: String
    let goalAmount: Int
    let currentAmount: Int
    let achievementRate: Int
    let emoji: String
}
