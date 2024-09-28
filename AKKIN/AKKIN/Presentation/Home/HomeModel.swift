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
}

// MARK: - Dummy Data Extension
extension HomeModel {

    static var dailyDummy: HomeModel {
        return HomeModel(type: "daily", savedAmount: 10000, expenseAmount: 3000, availableAmount: 7000)
    }

    static var allDummy: HomeModel {
        return HomeModel(type: "all", savedAmount: 50000, expenseAmount: 20000, availableAmount: 30000)
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
