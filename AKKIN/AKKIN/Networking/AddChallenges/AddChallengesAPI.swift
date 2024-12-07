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
}

