//
//  DataManager.swift
//  AKKIN
//
//  Created by 박지윤 on 8/28/24.
//

class DataManager {
    static let shared = DataManager()

    var currentYear: Int? = 2024
    var currentMonth: Int? = 8

    private init() {}
    
    func updateDate(year: Int, month: Int) {
        currentYear = year
        currentMonth = month
    }

    func updateMonth(month: Int) {
        currentMonth = month
    }
}
