//
//  DummyData.swift
//  AKKIN
//
//  Created by 박지윤 on 8/15/24.
//

import UIKit

struct MonthAnalysis {
    let category: String
    let percent: Double
    let color: UIColor
    let firstFlag: Bool
}

extension MonthAnalysis {
    static let monthAnalysisList = [
        MonthAnalysis(category: "식사",
                      percent: 30.4,
                      color: .akkinAnalysisRed,
                      firstFlag: true),
        MonthAnalysis(category: "교통",
                      percent: 21.7,
                      color: .akkinAnalysisGray,
                      firstFlag: false),
        MonthAnalysis(category: "기타",
                      percent: 15.1,
                      color: .akkinAnalysisBlue,
                      firstFlag: false),
        MonthAnalysis(category: "카페/간식",
                      percent: 5.6,
                      color: .akkinAnalysisPink,
                      firstFlag: false),
        MonthAnalysis(category: "문화/취미",
                      percent: 2.1,
                      color: .akkinAnalysisGreen,
                      firstFlag: false)
    ]
}
