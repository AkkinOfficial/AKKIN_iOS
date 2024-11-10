//
//  AppleLoginResponse.swift
//  AKKIN
//
//  Created by 박지윤 on 2023/11/27.
//

struct AppleLoginResponse: Codable {
    let status: Int
    let code: String
    let timestamp: String
    let body: TokenID
}

struct TokenID: Codable {
    let accessToken: String
    let accessTokenExpiredIn: CLong
    let refreshToken: String
    let refreshTokenExpiredIn: CLong
}
