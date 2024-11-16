//
//  AddChellengesResponse.swift
//  AKKIN
//
//  Created by 성현주 on 10/8/24.
//

import Foundation

struct AddChellengesResponse: Codable {
    let status: Int
    let code: String
    let timestamp: String
    let body: AddChellengesBody
}

struct AddChellengesBody: Codable {
    let authorId: Int
    let challengeId: String
    let debtId: String
}
