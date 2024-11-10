//
//  SavingsAPI.swift
//  AKKIN
//
//  Created by 박지윤 on 10/12/24.
//

import Moya
import Foundation

enum SavingsAPI {
    case getSavings(year: Int, month: Int)
    case getSavingsDate(date: String)
}

extension SavingsAPI: TargetType {
    var path: String {
        switch self {
        case .getSavings:
            return URLConst.savings
        case .getSavingsDate:
            return URLConst.savingsDate
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getSavings, .getSavingsDate:
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
        case .getSavingsDate(let date):
            return .requestParameters(
                parameters: ["date": date],
                encoding: URLEncoding.queryString)
        }
    }
}
