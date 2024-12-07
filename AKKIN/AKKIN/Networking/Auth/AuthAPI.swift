//
//  AppleLoginAPI.swift
//  AKKIN
//
//  Created by 박지윤 on 2023/09/24.
//

import Moya
import Foundation

enum AuthAPI {
    case postAppleLogin(code: String)
    case postAppleRevoke(appleToken: String, authorizationCode: String)
    case getAppleLogout
    case refreshToken(refreshToken: String)
}

extension AuthAPI: TargetType {
    var path: String {
        switch self {
        case .postAppleLogin:
            return URLConst.appleLogin
        case .postAppleRevoke:
            return URLConst.appleRevoke
        case .getAppleLogout:
            return URLConst.appleLogout
        case .refreshToken:
            return URLConst.authRefresh
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .postAppleLogin, .postAppleRevoke, .refreshToken:
            return .post
        case .getAppleLogout:
            return .get
        }
    }

    var task: Moya.Task {
        switch self {
        case .postAppleLogin(let code):
            return .requestParameters(parameters: [
                "code": code
            ], encoding: JSONEncoding.default)
        case .postAppleRevoke(let appleToken, let authorizationCode):
            return .requestParameters(parameters: [
                "appleToken": appleToken,
                "authorizationCode": authorizationCode
            ], encoding: JSONEncoding.default)
        case .getAppleLogout:
            return .requestPlain
        case .refreshToken(let refreshToken):
            return .requestParameters(parameters: ["Authorization-Refresh": refreshToken], encoding: JSONEncoding.default)
        }
    }

    var headers: [String : String]? {
        return  ["Content-Type": "application/json"]
   }
}
