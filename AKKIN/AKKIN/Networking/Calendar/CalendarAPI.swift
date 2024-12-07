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
    case patchExpenses(id: Int, request: ExpenseRequest)
    case deleteExpenses(id: Int)
}

extension CalendarAPI: TargetType {
    var path: String {
        switch self {
        case .getSavings:
            return URLConst.savings
        case .getExpenses:
            return URLConst.expenses
        case let .patchExpenses(id, _), let .deleteExpenses(id):
            return URLConst.expenses + "/\(id)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getSavings, .getExpenses:
            return .get
        case .patchExpenses:
            return .patch
        case .deleteExpenses:
            return .delete
        }
    }

    var task: Moya.Task {
        switch self {
        case let .getSavings(year, month):
            return .requestParameters(
                parameters: ["year": year,
                             "month": month],
                encoding: URLEncoding.queryString)
        case let .getExpenses(date):
            return .requestParameters(
                parameters: ["date": date],
                encoding: URLEncoding.queryString)
        case let .patchExpenses(_, request):
            return .requestParameters(parameters: [
                "amount": request.amount,
                "content": request.content,
                "memo": request.memo,
                "date": request.date,
                "category": request.category
            ], encoding: JSONEncoding.default)
        case .deleteExpenses:
            return .requestPlain
        }
    }
}

