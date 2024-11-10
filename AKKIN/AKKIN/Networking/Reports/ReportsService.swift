//
//  ReportServices.swift
//  AKKIN
//
//  Created by 박지윤 on 10/12/24.
//

import Foundation
import Moya

final class ReportsService {

    private var reportsProvider = MoyaProvider<ReportsAPI>(plugins: [MoyaLoggerPlugin()])

    private enum ResponseData {
        case getReports
    }

    public func getReports(completion: @escaping (NetworkResult<Any>) -> Void) {
        reportsProvider.request(.getReports) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data

                let networkResult = self.judgeStatus(by: statusCode, data, responseData: .getReports)
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
            case .getReports:
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
        case .getReports:
            let decodedData = try? decoder.decode(ReportsResponse.self, from: data)
            return .success(decodedData ?? "success")
        }
    }
}
