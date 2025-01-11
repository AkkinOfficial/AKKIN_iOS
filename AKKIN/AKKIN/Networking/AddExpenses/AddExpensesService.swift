//
//  AddExpensesService.swift
//  AKKIN
//
//  Created by 성현주 on 10/6/24.
//

import Foundation
import Moya

final class AddExpenseService {
    private var mainProvider = MoyaProvider<AddExpensesAPI>(plugins: [MoyaLoggerPlugin()])

    private enum ResponseData {
        case postAddExpense
    }

    public func postAddExpense(request: ExpenseRequest, completion: @escaping (NetworkResult<Any>) -> Void) {
        mainProvider.request(.postExpense(request: request)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data

                let networkResult = self.judgeStatus(by: statusCode, data: data, responseData: .postAddExpense)
                completion(networkResult)

            case .failure(let error):
                print(error)
            }
        }
    }

    private func judgeStatus(by statusCode: Int, data: Data, responseData: ResponseData) -> NetworkResult<Any> {
        let decoder = JSONDecoder()

        switch statusCode {
        case 200..<300:
            switch responseData {
            case .postAddExpense:
                return isValidData(data: data, responseData: responseData)
            }
        case 400..<500:
            guard let decodedData = try? decoder.decode(ErrorResponse.self, from: data) else {
                return .pathErr
            }
            return .requestErr(decodedData)
        case 500:
            return .serverErr
        default:
            return .networkFail
        }
    }

    private func isValidData(data: Data, responseData: ResponseData) -> NetworkResult<Any> {
        let decoder = JSONDecoder()

        switch responseData {
        case .postAddExpense:
            guard let decodedData = try? decoder.decode(AddExpenseResponse.self, from: data) else {
                return .pathErr
            }
            return .success(decodedData)
        }
    }
}
