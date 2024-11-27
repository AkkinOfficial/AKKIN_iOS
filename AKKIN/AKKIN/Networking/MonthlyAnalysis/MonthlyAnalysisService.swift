//
//  MonthlyAnalysisService.swift
//  AKKIN
//
//  Created by 박지윤 on 10/12/24.
//

import Foundation
import Moya

final class MonthlyAnalysisService {

    private var monthlyAnalysisProvider = MoyaProvider<MonthlyAnalysisAPI>(plugins: [MoyaLoggerPlugin()])

    private enum ResponseData {
        case getMonthlyAnaylsis
    }

    public func getReports(year: Int, month: Int, completion: @escaping (NetworkResult<Any>) -> Void) {
        monthlyAnalysisProvider.request(.getMonthlyAnaylsis(year: year, month: month)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data

                let networkResult = self.judgeStatus(by: statusCode, data, responseData: .getMonthlyAnaylsis)
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
            case .getMonthlyAnaylsis:
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
        case .getMonthlyAnaylsis:
            let decodedData = try? decoder.decode(MonthlyAnalysisResponse.self, from: data)
            return .success(decodedData ?? "success")
        }
    }
}
