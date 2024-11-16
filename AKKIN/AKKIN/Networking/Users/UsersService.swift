//
//  UsersService.swift
//  AKKIN
//
//  Created by 박지윤 on 10/13/24.
//

import Foundation
import Moya

final class UsersService {

    private var usersProvider = MoyaProvider<UsersAPI>(plugins: [MoyaLoggerPlugin()])

    private enum ResponseData {
        case getUser
        case putUserNickname(request: UserRequest)
    }

    public func getUser(completion: @escaping (NetworkResult<Any>) -> Void) {
        usersProvider.request(.getUser) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data

                let networkResult = self.judgeStatus(by: statusCode, data, responseData: .getUser)
                completion(networkResult)

            case .failure(let error):
                print(error)
            }
        }
    }

    public func putUserNickname(request: UserRequest, completion: @escaping (NetworkResult<Any>) -> Void) {
        usersProvider.request(.putUserNickname(request: request)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data

                let networkResult = self.judgeStatus(by: statusCode, data, responseData: .putUserNickname(request: request))
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
            case .getUser, .putUserNickname:
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
        case .getUser, .putUserNickname:
            let decodedData = try? decoder.decode(UsersResponse.self, from: data)
            return .success(decodedData ?? "success")
        }
    }
}



