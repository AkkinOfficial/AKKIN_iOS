//
//  DataManager.swift
//  AKKIN
//
//  Created by 박지윤 on 8/28/24.
//

import Foundation

class DataManager {
    static let shared = DataManager()

    var currentYear: Int?
    var currentMonth: Int?

    private init() {
        let now = Date()
        let calendar = Calendar.current

        currentYear = calendar.component(.year, from: now)
        currentMonth = calendar.component(.month, from: now)
    }

    func updateDate(year: Int, month: Int) {
        currentYear = year
        currentMonth = month
    }

    func updateMonth(month: Int) {
        currentMonth = month
    }
}
