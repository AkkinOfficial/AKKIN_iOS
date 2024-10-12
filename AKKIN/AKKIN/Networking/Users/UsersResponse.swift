//
//  UsersResponse.swift
//  AKKIN
//
//  Created by 박지윤 on 10/13/24.
//

struct UsersResponse: Codable {
    let status: Int
    let code: String
    let timestamp: String
    let body: Users
}

struct Users: Codable {
    let id: Int
    let nickname: String
}

struct UserRequest {
    let nickname: String
}
