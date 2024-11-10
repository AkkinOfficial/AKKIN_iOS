//
//  ReportsResponse.swift
//  AKKIN
//
//  Created by 박지윤 on 10/12/24.
//

struct ReportsResponse: Codable {
    let status: Int
    let code: String
    let timestamp: String
    let body: Reports
}

struct ReportsErrorResponse: Codable {
    let status: Int
    let code: String
    let timestamp: String
    let body: ErrorBody
}

struct Reports: Codable {
    let id: Int
    let totalSavedAmount: Int
    let mostSavedDate: String
    let mostSavedAmount: Int
    let mostSpentDate: String
    let mostSpentAmount: Int
    let categoryAnalysis: [CategoryAnalysis]
}

struct CategoryAnalysis: Codable {
    let category: String
    let categoryEnum: String
    let ratio: Int
    let amount: Int
}

struct ErrorBody: Codable {
    let message: String
}
