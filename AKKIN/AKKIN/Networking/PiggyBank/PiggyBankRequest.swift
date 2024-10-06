//
//  PiggyBankRequest.swift
//  AKKIN
//
//  Created by 신종원 on 10/6/24.
//

import Foundation

struct PiggyBankRequest: Codable {
    let startDate: String
    let endDate: String
    let goalAmount: Int
    let name: String
    let memo: String
    let emoji: String
}
