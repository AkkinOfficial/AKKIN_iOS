//
//  ReportsAPI.swift
//  AKKIN
//
//  Created by 박지윤 on 10/12/24.
//

import Moya
import Foundation

enum ReportsAPI {
    case getReports
}

extension ReportsAPI: TargetType {
    var path: String {
        switch self {
        case .getReports:
            return URLConst.reports
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getReports:
            return .get
        }
    }

    var task: Moya.Task {
        switch self {
        case .getReports:
            return .requestPlain
        }
    }
}
