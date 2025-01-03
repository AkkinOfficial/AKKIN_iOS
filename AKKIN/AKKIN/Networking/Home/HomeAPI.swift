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
    case deleteChallenge(challengeId: Int)
}

extension HomeAPI: TargetType {
    var path: String {
        switch self {
        case .getExpenseSummary:
            return URLConst.homeExpensesSummary
        case .deleteChallenge(let challengeId):
            return URLConst.addChallenges + "/\(challengeId)"
        }
    }

    var method: Moya.Method {
        switch self {
        case .getExpenseSummary:
            return .get
        case .deleteChallenge:
            return .delete
        }
    }

    var task: Moya.Task {
        switch self {
        case .getExpenseSummary(let type):
            return .requestParameters(parameters: ["type": type], encoding: URLEncoding.queryString)
        case .deleteChallenge:
            return .requestPlain
        }
    }
}
