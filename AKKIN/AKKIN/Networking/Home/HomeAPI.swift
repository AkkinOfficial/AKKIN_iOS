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
            return URLConst.homeExpensesSummary
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

    //헤더에 임의로 추가해뒀습니다 
    var headers: [String: String]? {
        return [
            "Content-Type": "application/json",
            "Authorization": "Bearer eyJhbGciOiJIUzUxMiJ9.eyJlbWFpbCI6Imh5dW5qb29AZ21haWwuY29tIiwicm9sZXMiOlsiUk9MRV9BRE1JTiJdLCJpYXQiOjE3MjgyNDQyMjcsImV4cCI6MTk0OTAwMzQyN30.zTzlvZPB2MBJdn5WbyILoa7pjpgub4niPMLUhQtBaEFcOVb6C7rjTSQhgZi41z04jGNnn8o0GzyKUJ2Fe1RZJQ"
        ]
    }
}
