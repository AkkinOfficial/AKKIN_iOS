//
//  AddChallengesRequest.swift
//  AKKIN
//
//  Created by 성현주 on 10/8/24.
//

import Foundation

struct AddChallengesRequest: Codable {
    let startDate: String
    let endDate: String
    let goalAmount: Int
}
//{"endDate":"2024-10-31","goalAmount":50000,"startDate":"2024-10-16"}
