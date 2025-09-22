//
//  HomeModel.swift
//  AKKIN
//
//  Created by 성현주 on 9/29/24.
//
import UIKit

struct HomeModel {
    let type: String
    let savedAmount: Int
    let expenseAmount: Int
    let availableAmount: Int

    var formattedSavedAmount: String {
        return formattedAmount(savedAmount)
    }

    var formattedExpenseAmount: String {
        return formattedAmount(expenseAmount)
    }

    var formattedAvailableAmount: String {
        return formattedAmount(availableAmount)
    }

    private func formattedAmount(_ amount: Int) -> String {
        return NumberFormatter.localizedString(from: NSNumber(value: amount), number: .decimal)
    }
}

// MARK: - Dummy Data Extension
extension HomeModel {
    static var dailyDummy: HomeModel {
        return HomeModel(type: "daily", savedAmount: 27667, expenseAmount: 33333, availableAmount: 61000)
    }

    static var allDummy: HomeModel {
        return HomeModel(type: "all", savedAmount: 98920, expenseAmount: 91080, availableAmount: 300000)
    }

    static func dummy(for type: String) -> HomeModel? {
        switch type {
        case "daily":
            return HomeModel.dailyDummy
        case "all":
            return HomeModel.allDummy
        default:
            return nil
        }
    }
}
