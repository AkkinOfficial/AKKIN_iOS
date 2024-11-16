//
//  AddChallengesService.swift
//  AKKIN
//
//  Created by 성현주 on 10/8/24.
//

import Foundation
import Moya

final class AddChallengesService {
    private var mainProvider = MoyaProvider<AddChallengesAPI>(plugins: [MoyaLoggerPlugin()])

    private enum ResponseData {
        case postChallenges
    }

    public func postChallenges(request: AddChallengesRequest, completion: @escaping (NetworkResult<Any>) -> Void) {
        mainProvider.request(.postChallenges(request: request)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data

                let networkResult = self.judgeStatus(by: statusCode, data: data, responseData: .postChallenges)
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
            case .postChallenges:
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
        case .postChallenges:
            guard let decodedData = try? decoder.decode(AddChellengesResponse.self, from: data) else {
                return .pathErr
            }
            return .success(decodedData)
        }
    }
}

