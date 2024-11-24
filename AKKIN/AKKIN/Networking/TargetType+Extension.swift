//
//  TargetType+Extension.swift
//  AKKIN
//
//  Created by MK-Mac-413 on 2023/09/04.
//

import Foundation

import Moya

extension TargetType {
    var baseURL: URL {
        //TODO: - baseURL congfig로 이동
        URL(string: URLConst.base)!
    }

    var headers: [String : String]? {
        let accessToken = KeychainManager.shared.load(key: "accessToken") ?? ""
        let refreshToken = KeychainManager.shared.load(key: "refreshToken") ?? ""
        let header = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(accessToken)",
//            "Authorization-Refresh": "Bearer \()"
        ]
        return header
    }
}
