//
//  DummyData.swift
//  AKKIN
//
//  Created by 박지윤 on 8/15/24.
//

import UIKit

struct Current {
    var year: Int
    var month: Int
}

extension Current {
    static let currentData = Current(year: 2024, month: 8)
}

struct MonthAnalysis {
    var month: Int
    let category: String
    let percent: Double
    let expense: Int
    let color: UIColor
    let firstFlag: Bool
}

extension MonthAnalysis {
    static let monthAnalysisList = [
        MonthAnalysis(month: 8,
                      category: "식사",
                      percent: 30.4,
                      expense: 315817,
                      color: .akkinAnalysisRed,
                      firstFlag: true),
        MonthAnalysis(month: 8,
                      category: "교통",
                      percent: 21.7,
                      expense: 181680,
                      color: .akkinAnalysisGray,
                      firstFlag: false),
        MonthAnalysis(month: 8,
                      category: "기타",
                      percent: 15.1,
                      expense: 99000,
                      color: .akkinAnalysisBlue,
                      firstFlag: false),
        MonthAnalysis(month: 8,
                      category: "카페/간식",
                      percent: 5.6,
                      expense: 20240,
                      color: .akkinAnalysisPink,
                      firstFlag: false),
        MonthAnalysis(month: 8,
                      category: "문화/취미",
                      percent: 2.1,
                      expense: 51330,
                      color: .akkinAnalysisGreen,
                      firstFlag: false)
    ]

    static let monthAnalysisEmtpyList: [MonthAnalysis] = []
}
