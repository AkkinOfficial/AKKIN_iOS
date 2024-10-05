//
//  AddExpensesAPI.swift
//  AKKIN
//
//  Created by 성현주 on 10/6/24.
//

import Foundation
import Moya

enum AddExpensesAPI {
    case postExpense(request: AddExpenseRequest)}

extension AddExpensesAPI: TargetType {
    var path: String {
        switch self {
        case .postExpense:
            return URLConst.addExpenses
        }
    }

    var method: Moya.Method {
        switch self {
        case .postExpense:
            return .post
        }
    }

    var task: Moya.Task {
        switch self {
        case .postExpense(let request):
            return .requestJSONEncodable(request)
        }
    }

    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
}
