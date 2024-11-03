//
//  ErrorResponse.swift
//  AKKIN
//
//  Created by 박지윤 on 2023/09/24.
//

struct ErrorResponse: Codable {
    let status: Int?
    let code: String?
    let timeStamp: String?
    let body: String?
}
