//
//  CalendarService.swift
//  AKKIN
//
//  Created by 박지윤 on 11/30/24.
//

import Foundation
import Moya

final class CalendarService {

    private var calendarProvider = MoyaProvider<CalendarAPI>(plugins: [MoyaLoggerPlugin()])

    private enum ResponseData {
        case getSavings(year: Int, month: Int)
        case getExpenses(date: String)
        case patchExpenses(request: ExpenseRequest)
        case deleteExpenses
    }

    public func getSavings(year: Int, month: Int, completion: @escaping (NetworkResult<Any>) -> Void) {
        calendarProvider.request(.getSavings(year: year, month: month)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data

                let networkResult = self.judgeStatus(by: statusCode, data, responseData: .getSavings(year: year, month: month))
                completion(networkResult)

            case .failure(let error):
                print(error)
            }
        }
    }

    public func getExpenses(date: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        calendarProvider.request(.getExpenses(date: date)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data

                let networkResult = self.judgeStatus(by: statusCode, data, responseData: .getExpenses(date: date))
                completion(networkResult)

            case .failure(let error):
                print(error)
            }
        }
    }

    public func patchExpenses(id: Int, request: ExpenseRequest, completion: @escaping (NetworkResult<Any>) -> Void) {
        calendarProvider.request(.patchExpenses(id: id, request: request)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data

                let networkResult = self.judgeStatus(by: statusCode, data, responseData: .patchExpenses(request: request))
                completion(networkResult)

            case .failure(let error):
                print(error)
            }
        }
    }

    public func deleteExpenses(id: Int, completion: @escaping (NetworkResult<Any>) -> Void) {
        calendarProvider.request(.deleteExpenses(id: id)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data

                let networkResult = self.judgeStatus(by: statusCode, data, responseData: .deleteExpenses)
                completion(networkResult)

            case .failure(let error):
                print(error)
            }
        }
    }

    private func judgeStatus(by statusCode: Int, _ data: Data, responseData: ResponseData) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        switch statusCode {
        case 200..<300:
            switch responseData {
            case .getSavings, .getExpenses, .patchExpenses, .deleteExpenses:
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
        case .getSavings:
            let decodedData = try? decoder.decode(SavingsResponse.self, from: data)
            return .success(decodedData ?? "success")
        case .getExpenses:
            let decodedData = try? decoder.decode(ExpensesResponse.self, from: data)
            return .success(decodedData ?? "success")
        case .patchExpenses:
            let decodedData = try? decoder.decode(PatchExpensesResponse.self, from: data)
            return .success(decodedData ?? "success")
        case .deleteExpenses:
            let decodedData = try? decoder.decode(BlankDataResponse.self, from: data)
            return .success(decodedData ?? "success")
        }
    }
}
