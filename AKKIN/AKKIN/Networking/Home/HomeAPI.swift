//
//  HomeAPI.swift
//  AKKIN
//
//  Created by 성현주 on 10/6/24.
//

import Foundation
import Moya

enum HomeAPI {
    case getExpenseSummary(type: String)
}

extension HomeAPI: TargetType {
    var path: String {
        switch self {
        case .getExpenseSummary:
            return URLConst.homeExpenseSummary
        }
    }

    var method: Moya.Method {
        switch self {
        case .getExpenseSummary:
            return .get
        }
    }

    var task: Moya.Task {
        switch self {
        case .getExpenseSummary(let type):
            return .requestParameters(parameters: ["type": type], encoding: URLEncoding.queryString)
        }
    }

    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
}
