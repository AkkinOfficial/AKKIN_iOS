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
    let body: AnalysisData
}

struct AnalysisData: Codable {
    let totalAmount: Int
    let element: [AnalysisElement]
}

struct AnalysisElement: Codable {
    let category: String
    let categoryEnum: String
    let ratio: Int
    let amount: Int
}

extension AnalysisData {
    static let emptyAnalysisData = AnalysisData(totalAmount: 0, element: [])
    static let testAnalysisData = AnalysisData(totalAmount: 10000,
                                               element: [AnalysisElement(category: "식사",
                                                                         categoryEnum: "🍽️",
                                                                         ratio: 21,
                                                                         amount: 25300),
                                                         AnalysisElement(category: "교통",
                                                                         categoryEnum: "🚃",
                                                                         ratio: 12,
                                                                         amount: 181680),
                                                         AnalysisElement(category: "생활",
                                                                        categoryEnum: "🛒",
                                                                        ratio: 34,
                                                                        amount: 63460)])

    func elementWithMaxAmount() -> AnalysisElement? {
        return self.element.max(by: { $0.amount < $1.amount })
    }
}

struct CategoryAnalysis: Codable {
    let category: String
    let categoryEnum: String
    let ratio: Int
    let amount: Int
}
