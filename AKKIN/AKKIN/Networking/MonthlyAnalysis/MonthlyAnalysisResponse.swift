//
//  MonthlyAnalysisResponse.swift
//  AKKIN
//
//  Created by 박지윤 on 10/12/24.
//

struct MonthlyAnalysisResponse: Codable {
    let status: Int
    let code: String
    let timestamp: String
    let body: Analysis
}

struct Analysis: Codable {
    let id: Int
    let totalSavedAmount: Int
    let mostSavedDate: String
    let mostSavedAmount: Int
    let mostSpentDate: String
    let mostSpentAmount: Int
    let categoryAnalysis: [CategoryAnalysis]
}

extension Analysis {
    static let empty = Analysis(id: 0,
                               totalSavedAmount: 0,
                               mostSavedDate: "",
                               mostSavedAmount: 0,
                               mostSpentDate: "",
                               mostSpentAmount: 0,
                               categoryAnalysis: [])
}

struct CategoryAnalysis: Codable {
    let category: String
    let categoryEnum: String
    let ratio: Int
    let amount: Int
}
