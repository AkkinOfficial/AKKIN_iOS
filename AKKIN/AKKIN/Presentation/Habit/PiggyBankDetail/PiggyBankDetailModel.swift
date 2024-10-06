//
//  PiggyBankDetailModel.swift
//  AKKIN
//
//  Created by 신종원 on 10/6/24.
//

import Foundation

struct PiggyBankDetailModel {
    let id: Int
    let name: String
    let memo: String
    let startDate: String
    let endDate: String
    let goalAmount: Int
    let currentAmount: Int
    let achievementRate: Int
    let emoji: String

    var formattedGoalAmount: String {
        return formattedAmount(goalAmount)
    }

    var formattedCurrentAmount: String {
        return formattedAmount(currentAmount)
    }

    private func formattedAmount(_ amount: Int) -> String {
        return NumberFormatter.localizedString(from: NSNumber(value: amount), number: .decimal)
    }
}

// MARK: - Dummy Data Extension
extension PiggyBankDetailModel {
    static var dummy: PiggyBankDetailModel {
        return PiggyBankDetailModel(id: 0, name: "아이패드 사기(D-2)", memo: "아이패드 꼭 살거니까 아무도 날 말리지마..~", startDate: "2024. 09. 15", endDate: "2024. 10. 05", goalAmount: 638000, currentAmount: 57420, achievementRate: 54, emoji: "🍎")
    }
}
