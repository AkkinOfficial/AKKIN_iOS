//
//  PiggyBankModel.swift
//  AKKIN
//
//  Created by 신종원 on 10/5/24.
//

import Foundation


enum ViewState {
    case success
    case empty
    case zero
}

struct PiggyBankModel {
    let id: Int
    let name: String
    let dueDates: Int
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
extension PiggyBankModel {
    static var dummy: PiggyBankModel {
        return PiggyBankModel(id: 0, name: "아이패드 사기(D-2)", dueDates: 2, goalAmount: 638000, currentAmount: 57420, achievementRate: 54, emoji: "🍎")
    }
}
