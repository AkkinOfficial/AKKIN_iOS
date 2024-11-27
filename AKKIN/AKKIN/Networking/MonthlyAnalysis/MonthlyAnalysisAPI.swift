//
//  MonthlyAnalysisAPI.swift
//  AKKIN
//
//  Created by 박지윤 on 10/12/24.
//

import Moya
import Foundation

enum MonthlyAnalysisAPI {
    case getMonthlyAnaylsis(year: Int, month: Int)
}

extension MonthlyAnalysisAPI: TargetType {
    var path: String {
        switch self {
        case .getMonthlyAnaylsis:
            return URLConst.monthlyAnalysis
        }
    }

    var method: Moya.Method {
        switch self {
        case .getMonthlyAnaylsis:
            return .get
        }
    }

    var task: Moya.Task {
        switch self {
        case .getMonthlyAnaylsis(let year, let month):
            return .requestParameters(
                parameters: [
                    "year": year,
                    "month": month
                ],
                encoding: URLEncoding.queryString)
        }
    }
}
