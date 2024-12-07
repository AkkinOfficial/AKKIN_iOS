//
//  MoyaLoggerPlugin.swift
//  AKKIN
//
//  Created by 박지윤 on 2023/09/24.
//

import Moya
import Foundation

final class MoyaLoggerPlugin: PluginType {

    // MARK: - 로깅 레벨 설정
    enum LogLevel {
        case request
        case response
        case error
        case none
    }

    private let logLevel: LogLevel

    // MARK: Initializer
    init(logLevel: LogLevel = .response) {
        self.logLevel = logLevel
    }

    // MARK: - Request 보낼 시 호출
    func willSend(_ request: RequestType, target: TargetType) {
        guard logLevel == .request || logLevel == .response else { return }
        guard let httpRequest = request.request else {
            print("--> 유효하지 않은 요청")
            return
        }

        let url = httpRequest.url?.absoluteString ?? "Invalid URL"
        let method = httpRequest.httpMethod ?? "unknown method"
        var log = "----------------------------------------------------\n1️⃣[\(method)] \(url)\n----------------------------------------------------\n"
        log.append("2️⃣API: \(target)\n")
        if let headers = httpRequest.allHTTPHeaderFields, !headers.isEmpty {
            log.append("header: \(headers)\n")
        }
        if let body = httpRequest.httpBody, let bodyString = String(bytes: body, encoding: String.Encoding.utf8) {
            log.append("\(bodyString)\n")
        }
        log.append("------------------- END \(method) -------------------")
        print(log)
    }

    // MARK: - Response 받을 시 호출
    func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        guard logLevel == .response || logLevel == .error else { return }

        switch result {
        case .success(let response):
            handleSuccess(response, target: target)
        case .failure(let error):
            handleError(error, target: target)
        }
    }

    private func handleSuccess(_ response: Response, target: TargetType) {
        let statusCode = response.statusCode
        
        if statusCode == 401 {
            handleTokenExpiration(target: target)
        } else {
            logResponse(response)
        }
    }

    private func handleError(_ error: MoyaError, target: TargetType) {
        if let response = error.response {
            handleSuccess(response, target: target)
        } else {
            logError(error)
        }
    }
    
    // MARK: - 401 Unauthorized Handling
    private func handleTokenExpiration(target: TargetType) {
        print("⚠️ 401 Unauthorized - AccessToken expired. Attempting to refresh token...")

        guard let refreshToken = KeychainManager.shared.load(key: "refreshToken") else {
            print("❌ No RefreshToken found. Logging out...")
            NotificationCenter.default.post(name: .didRequireLogin, object: nil)
            return
        }
        
        AuthService.shared.refreshAccessToken(refreshToken: refreshToken) { result in
            switch result {
            case .success(let tokenResponse):
                KeychainManager.shared.save(key: "accessToken", value: tokenResponse.body.accessToken)
                KeychainManager.shared.save(key: "refreshToken", value: tokenResponse.body.refreshToken)
                print("🔄 Tokens refreshed successfully.")
            case .requestErr:
                print("❌ requestErr. Logging out...")
                NotificationCenter.default.post(name: .didRequireLogin, object: nil)
            case .pathErr:
                print("❌ pathErr. Logging out...")
                NotificationCenter.default.post(name: .didRequireLogin, object: nil)
            case .serverErr:
                print("❌ serverErr. Logging out...")
                NotificationCenter.default.post(name: .didRequireLogin, object: nil)
            case .networkFail:
                print("❌ networkFail. Logging out...")
                NotificationCenter.default.post(name: .didRequireLogin, object: nil)
            }
        }
    }
    
    // MARK: Logging Helpers
    private func logResponse(_ response: Response) {
        let request = response.request
        let url = request?.url?.absoluteString ?? "nil"
        let statusCode = response.statusCode

        var log = "------------------- 네트워크 통신 성공했는가? -------------------"
        log.append("\n3️⃣[\(statusCode)] \(url)\n----------------------------------------------------\n")
        log.append("response: \n")
        if let reString = String(bytes: response.data, encoding: .utf8) {
            log.append("4️⃣\(reString)\n")
        }
        log.append("------------------- END HTTP -------------------")
        print(log)
    }

    private func logError(_ error: MoyaError) {
        var log = "네트워크 오류"
        log.append("<-- \(error.errorCode)\n")
        log.append("\(error.failureReason ?? error.errorDescription ?? "unknown error")\n")
        log.append("<-- END HTTP")
        print(log)
    }
}
