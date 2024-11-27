//
//  AppleLoginManager.swift
//  AKKIN
//
//  Created by 신종원 on 11/24/24.
//

import AuthenticationServices

final class AppleLoginManager: NSObject {
    static let shared = AppleLoginManager()

    func performLogin(completion: @escaping (Result<AppleLoginResponse, Error>) -> Void) {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]

        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.performRequests()

        self.completion = completion
    }

    private var completion: ((Result<AppleLoginResponse, Error>) -> Void)?
}


extension AppleLoginManager: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        guard let credential = authorization.credential as? ASAuthorizationAppleIDCredential,
              let codeData = credential.authorizationCode,
              let codeString = String(data: codeData, encoding: .utf8) else {
            completion?(.failure(NSError(domain: "AppleLoginManager", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid authorization code"])))
            return
        }

        print("✅ Authorization Code Received: \(codeString)")

        AuthService.shared.postAppleLogin(code: codeString) { [weak self] result in
            guard let self = self else { return }
            self.completion?(self.convertNetworkResultToResult(result))
        }
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        completion?(.failure(error))
    }

    // MARK: Helper Methods
    private func convertNetworkResultToResult(_ networkResult: NetworkResult<AppleLoginResponse>) -> Result<AppleLoginResponse, Error> {
        switch networkResult {
        case .success(let response):
            return .success(response)
        case .requestErr(let errorResponse):
            let error = NSError(domain: "AuthService", code: 400, userInfo: [NSLocalizedDescriptionKey: errorResponse.code])
            return .failure(error)
        case .pathErr:
            let error = NSError(domain: "AuthService", code: 404, userInfo: [NSLocalizedDescriptionKey: "Invalid path"])
            return .failure(error)
        case .serverErr:
            let error = NSError(domain: "AuthService", code: 500, userInfo: [NSLocalizedDescriptionKey: "Server error occurred"])
            return .failure(error)
        case .networkFail:
            let error = NSError(domain: "AuthService", code: -1009, userInfo: [NSLocalizedDescriptionKey: "Network failure occurred"])
            return .failure(error)
        }
    }
}
