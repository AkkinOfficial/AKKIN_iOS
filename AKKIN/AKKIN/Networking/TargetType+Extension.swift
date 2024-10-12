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
        let header = [
            "Content-Type": "application/json",
            "Authorization": ""
        ]
        return header
    }
}
