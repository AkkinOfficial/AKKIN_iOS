//
//  MonthlyAnalysisResponse.swift
//  AKKIN
//
//  Created by 박지윤 on 10/12/24.
//

import UIKit

struct MonthlyAnalysisResponse: Codable {
    let status: Int
    let code: String
    let timestamp: String
    let body: AnalysisData
}

struct AnalysisData: Codable {
    let totalAmount: Int
    let elements: [AnalysisElement]
}

struct AnalysisElement: Codable {
    let category: String
    let categoryEnum: String
    let ratio: Double
    let amount: Int
}

extension AnalysisData {
    static let emptyAnalysisData = AnalysisData(totalAmount: 0, elements: [])
    static let testAnalysisData = AnalysisData(totalAmount: 10000,
                                               elements: [AnalysisElement(category: "식사",
                                                                         categoryEnum: "🍽️",
                                                                         ratio: 21.2,
                                                                         amount: 25300),
                                                         AnalysisElement(category: "교통",
                                                                         categoryEnum: "🚃",
                                                                         ratio: 12.5,
                                                                         amount: 181680),
                                                         AnalysisElement(category: "생활",
                                                                        categoryEnum: "🛒",
                                                                         ratio: 34.3,
                                                                        amount: 63460)])

    func elementWithMaxAmount() -> AnalysisElement? {
        return self.elements.max(by: { $0.amount < $1.amount })
    }
}

extension AnalysisElement {
    func getCategoryColor(_ category: String) -> UIColor {
        let categoryColorMap: [String: UIColor] = [
            "식사": .akkinMealColor,
            "카페/간식": .akkinCafeColor,
            "술/유흥": .akkinEntertainColor,
            "편의점": .akkinConvenienceColor,
            "의류": .akkinClothingColor,
            "미용": .akkinBeautyColor,
            "문화/취미": .akkinHobbyColor,
            "생활": .akkinLifeColor,
            "여행/숙박": .akkinTravelColor,
            "교통": .akkinTransportColor,
            "의료/건강": .akkinMedicalColor,
            "교육": .akkinEducationColor,
            "통신": .akkinCommunicationColor,
            "회비": .akkinMembershipColor,
            "경조사": .akkinEventColor,
            "기타": .akkinEtcColor
        ]

        return categoryColorMap[category] ?? .white
    }
}

struct CategoryAnalysis: Codable {
    let category: String
    let categoryEnum: String
    let ratio: Int
    let amount: Int
}

struct ChallengeData: Codable {
    let startDate: Int
    let endDate: Int
}

extension ChallengeData {
    static let emptyChallengeData = ChallengeData(startDate: 0, endDate: 0)
    static let testChallengeData = ChallengeData(startDate: 2024, endDate: 2024)
}
