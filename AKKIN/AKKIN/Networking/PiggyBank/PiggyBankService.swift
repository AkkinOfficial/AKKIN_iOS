//
//  PiggyBankService.swift
//  AKKIN
//
//  Created by 신종원 on 10/6/24.
//

import Foundation
import Moya

final class PiggyBankService {
    private var mainProvider = MoyaProvider<PiggyBankAPI>(plugins: [MoyaLoggerPlugin()])

    private enum ResponseData {
        case getPiggyBankSummary
        case getPiggyBankDetailSummary
        case deletePiggyBank
    }

    public func getPiggyBankSummary(completion: @escaping (NetworkResult<Any>) -> Void) {
        mainProvider.request(.getPiggyBankSummary) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data

                let networkResult = self.judgeStatus(by: statusCode, data, responseData: .getPiggyBankSummary)
                completion(networkResult)

            case .failure(let error):
                print(error)

            }
        }
    }
    public func getPiggyBankDetailSummary(bankId: Int, completion: @escaping (NetworkResult<Any>) -> Void) {
        mainProvider.request(.getPiggyBankDetailSummary(bankId: bankId)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data

                let networkResult = self.judgeStatus(by: statusCode, data, responseData: .getPiggyBankDetailSummary)
                completion(networkResult)

            case .failure(let error):
                print(error)

            }
        }
    }
    public func deletePiggyBank(bankId: Int, completion: @escaping (NetworkResult<Any>) -> Void) {
        mainProvider.request(.deletePiggyBank(bankId: bankId)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data

                let networkResult = self.judgeStatus(by: statusCode, data, responseData: .deletePiggyBank)
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
            case .getPiggyBankSummary:
                return isValidData(data: data, responseData: responseData)
            case .deletePiggyBank:
                return isValidData(data: data, responseData: responseData)
            case .getPiggyBankDetailSummary:
                return isValidData(data: data, responseData: responseData)
            }
        case 400..<500:
            guard let decodedData = try? decoder.decode(ErrorResponse.self, from: data) else {
                print("path1")
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
        case .getPiggyBankSummary:
            guard let decodedData = try? decoder.decode(PiggyBankResponse.self, from: data) else {
                print("path2")
                return .pathErr
            }
            return .success(decodedData)
        case .deletePiggyBank:
            do {
                let decodedData = try decoder.decode(PiggyBankDeleteResponse.self, from: data)
                return .success(decodedData)
            } catch {
                print("Decoding error: \(error)")
                return .pathErr
            }
        case .getPiggyBankDetailSummary:
            do {
                let decodedData = try decoder.decode(PiggyBankDetailResponse.self, from: data)
                return .success(decodedData)
            } catch {
                print("Decoding error: \(error)")
                return .pathErr
            }
        }
    }
}
