//
//  UsersAPI.swift
//  AKKIN
//
//  Created by 박지윤 on 10/13/24.
//

import Moya
import Foundation

enum UsersAPI {
    case getUser
    case putUserNickname(request: UserRequest)
}

extension UsersAPI: TargetType {
    var path: String {
        switch self {
        case .getUser:
            return URLConst.users
        case .putUserNickname:
            return URLConst.usersNickname
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getUser:
            return .get
        case .putUserNickname:
            return .put
        }
    }

    var task: Moya.Task {
        switch self {
        case .getUser:
            return .requestPlain
        case .putUserNickname(let request):
            return .requestParameters(
                parameters: ["nickname": request.nickname],
                encoding: URLEncoding.queryString)
        }
    }
}
