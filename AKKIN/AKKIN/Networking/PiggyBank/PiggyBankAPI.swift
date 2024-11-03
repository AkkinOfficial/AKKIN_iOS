//
//  PiggyBankAPI.swift
//  AKKIN
//
//  Created by 신종원 on 10/6/24.
//

import Foundation
import Moya

enum PiggyBankAPI {
    case getPiggyBankSummary
    case getPiggyBankDetailSummary(bankId: Int)
    case deletePiggyBank(bankId: Int)
}

extension PiggyBankAPI: TargetType {
    var path: String {
        switch self {
        case .getPiggyBankSummary:
            return URLConst.piggyBank
        case .deletePiggyBank(let bankId):
            return URLConst.piggyBank + "/\(bankId)"
        case .getPiggyBankDetailSummary(let bankId):
            return URLConst.piggyBank + "/\(bankId)"
        }
    }

    var method: Moya.Method {
        switch self {
        case .getPiggyBankSummary, .getPiggyBankDetailSummary:
            return .get
        case .deletePiggyBank:
            return .delete
        }
    }

    var task: Moya.Task {
        switch self {
        case .getPiggyBankSummary, .deletePiggyBank, .getPiggyBankDetailSummary:
            return .requestPlain
        }
    }

    var headers: [String: String]? {
        return ["Content-Type": "application/json", "Authorization": "Bearer eyJhbGciOiJIUzUxMiJ9.eyJlbWFpbCI6Impvbmd3b25AZ21haWwuY29tIiwicm9sZXMiOlsiUk9MRV9BRE1JTiJdLCJpYXQiOjE3MjgyNDQyNjgsImV4cCI6MTk0OTAwMzQ2OH0.xO1oMy-J7eAQcJPxykEdTyx4pEO2Ie5iKydf-Tm5La37DY6kkwS-1z42db3czT373F_E5p7DtuZNWScz0ft58A"]
    }
}

