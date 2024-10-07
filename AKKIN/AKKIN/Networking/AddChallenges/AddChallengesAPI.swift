//
//  AddChallengesAPI.swift
//  AKKIN
//
//  Created by 성현주 on 10/8/24.
//

import Foundation
import Moya

enum AddChallengesAPI {
    case postChallenges(request: AddChallengesRequest)}

extension AddChallengesAPI: TargetType {
    var path: String {
        switch self {
        case .postChallenges:
            return URLConst.addChallenges
        }
    }

    var method: Moya.Method {
        switch self {
        case .postChallenges:
            return .post
        }
    }

    var task: Moya.Task {
        switch self {
        case .postChallenges(let request):
            return .requestJSONEncodable(request)
        }
    }

    var headers: [String: String]? {
        return [
            "Content-Type": "application/json",
            "Authorization": "Bearer eyJhbGciOiJIUzUxMiJ9.eyJlbWFpbCI6Imh5dW5qb29AZ21haWwuY29tIiwicm9sZXMiOlsiUk9MRV9BRE1JTiJdLCJpYXQiOjE3MjgyNDQyMjcsImV4cCI6MTk0OTAwMzQyN30.zTzlvZPB2MBJdn5WbyILoa7pjpgub4niPMLUhQtBaEFcOVb6C7rjTSQhgZi41z04jGNnn8o0GzyKUJ2Fe1RZJQ"
        ]
    }

}

