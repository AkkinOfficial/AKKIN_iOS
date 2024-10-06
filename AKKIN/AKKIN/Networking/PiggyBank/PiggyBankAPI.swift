//
//  PiggyBankAPI.swift
//  AKKIN
//
//  Created by 신종원 on 10/6/24.
//

import Foundation
import Moya

enum PiggyBankAPI {
    case getPiggyBankSummary(type: String)
}

extension PiggyBankAPI: TargetType {
    var path: String {
        switch self {
        case .getPiggyBankSummary:
            return URLConst.getPiggyBankSummary
        }
    }

    var method: Moya.Method {
        switch self {
        case .getPiggyBankSummary:
            return .get
        }
    }

    var task: Moya.Task {
        switch self {
        case .getPiggyBankSummary(let type):
            return .requestParameters(parameters: ["type": type], encoding: URLEncoding.queryString)
        }
    }

    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
}

