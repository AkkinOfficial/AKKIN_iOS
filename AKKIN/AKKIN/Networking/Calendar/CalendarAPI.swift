//
//  CalendarAPI.swift
//  AKKIN
//
//  Created by 박지윤 on 11/30/24.
//

import Moya
import Foundation

enum CalendarAPI {
    case getSavings(year: Int, month: Int)
    case getExpenses(date: String)
}

extension CalendarAPI: TargetType {
    var path: String {
        switch self {
        case .getSavings:
            return URLConst.savings
        case .getExpenses:
            return URLConst.getExpenses
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getSavings, .getExpenses:
            return .get
        }
    }

    var task: Moya.Task {
        switch self {
        case .getSavings(let year, let month):
            return .requestParameters(
                parameters: ["year": year,
                             "month": month],
                encoding: URLEncoding.queryString)
        case .getExpenses(let date):
            return .requestParameters(
                parameters: ["date": date],
                encoding: URLEncoding.queryString)
        }
    }
}

