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
}

