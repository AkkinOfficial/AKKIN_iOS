//
//  MakePiggyBankResponse.swift
//  AKKIN
//
//  Created by 신종원 on 10/9/24.
//

import Foundation

struct MakePiggyBankResponse: Codable {
    let status: Int
    let code: String
    let timestamp: String
    let body: BankID
}

struct BankID: Codable {
    let id: Int
    let authorId: Int
}
