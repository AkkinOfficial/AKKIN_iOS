//
//  AddExpenseModel.swift
//  AKKIN
//
//  Created by 성현주 on 9/22/24.
//

import Foundation
import UIKit

class ExpenseInfo {
    static let shared = ExpenseInfo()

    var icon: String?
    var amount: String = ""
    var content: String = ""
    var memo: String = ""
    var date: String = ""

    private var _category: String = ""

    var category: String {
        get {
            return _category
        }
        set {
            _category = mapCategory(newValue) 
        }
    }

    private init() { }

    private func mapCategory(_ value: String) -> String {
        switch value {
        case "식사":
            return "MEAL"
        case "카페/간식":
            return "CAFE_SNACK"
        case "술/유흥":
            return "DRINK_ENTERTAINMENT"
        case "편의점":
            return "CONVENIENCE_STORE"
        case "의류":
            return "CLOTHING"
        case "미용":
            return "BEAUTY"
        case "문화/취미":
            return "CULTURE_HOBBY"
        case "생활":
            return "LIVING"
        case "여행/숙박":
            return "TRAVEL_ACCOMMODATION"
        case "교통":
            return "TRANSPORTATION"
        case "의료/건강":
            return "MEDICAL_HEALTH"
        case "교육":
            return "EDUCATION"
        case "통신":
            return "COMMUNICATION"
        case "멤버십 회비":
            return "MEMBERSHIP_FEE"
        case "경조사":
            return "FAMILY_OCCASION"
        case "기타":
            return "MISC"
        default:
            return value
        }
    }
}
