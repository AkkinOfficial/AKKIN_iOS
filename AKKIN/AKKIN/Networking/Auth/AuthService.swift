//
//  AppleLoginService.swift
//  AKKIN
//
//  Created by 박지윤 on 2023/09/24.
//

import Foundation
import Moya

import Foundation
import Moya

final class AuthService {
    static let shared = AuthService()
    private var authProvider = MoyaProvider<AuthAPI>(plugins: [MoyaLoggerPlugin()])

    // MARK: - Public Methods

    /// Apple Login API 호출
    public func postAppleLogin(code: String, completion: @escaping (NetworkResult<AppleLoginResponse>) -> Void) {
        request(.postAppleLogin(code: code), responseType: AppleLoginResponse.self, completion: completion)
    }

    /// Apple Revoke API 호출
    public func postAppleRevoke(appleToken: String, authorizationCode: String, completion: @escaping (NetworkResult<BlankDataResponse>) -> Void) {
        request(.postAppleRevoke(appleToken: appleToken, authorizationCode: authorizationCode), responseType: BlankDataResponse.self, completion: completion)
    }

    /// Apple Logout API 호출
    public func getAppleLogout(completion: @escaping (NetworkResult<BlankDataResponse>) -> Void) {
        request(.getAppleLogout, responseType: BlankDataResponse.self, completion: completion)
    }

    // MARK: - Private Helper Methods

    /// 공통 요청 처리 메서드
    private func request<T: Decodable>(_ target: AuthAPI, responseType: T.Type, completion: @escaping (NetworkResult<T>) -> Void) {
        authProvider.request(target) { result in
            switch result {
            case .success(let response):
                let networkResult = self.judgeStatus(by: response.statusCode, data: response.data, responseType: responseType)
                completion(networkResult)
            case .failure(let error):
                print("❌ Network Error: \(error.localizedDescription)")
                completion(.networkFail)
            }
        }
    }

    /// 상태 코드 판별 및 데이터 처리
    private func judgeStatus<T: Decodable>(by statusCode: Int, data: Data, responseType: T.Type) -> NetworkResult<T> {
        let decoder = JSONDecoder()

        switch statusCode {
        case 200..<300:
            return decodeData(data: data, responseType: responseType)
        case 400..<500:
            if let errorResponse = try? decoder.decode(ErrorResponse.self, from: data) {
                return .requestErr(errorResponse as! T)
            } else {
                return .pathErr
            }
        case 500:
            return .serverErr
        default:
            return .networkFail
        }
    }

    /// 데이터 디코딩 처리
    private func decodeData<T: Decodable>(data: Data, responseType: T.Type) -> NetworkResult<T> {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(responseType, from: data)
            return .success(decodedData)
        } catch {
            print("❌ Decoding Error: \(error.localizedDescription)")
            return .pathErr
        }
    }
}
