//
//  CalendarResponse.swift
//  AKKIN
//
//  Created by 박지윤 on 11/30/24.
//

struct ExpensesResponse: Codable {
    let status: Int
    let code: String
    let timestamp: String
    let body: Expenses
}

struct PatchExpensesResponse: Codable {
    let status: Int
    let code: String
    let timestamp: String
    let body: PatchExpenses
}

struct PatchExpenses: Codable {
    let savedAmount: Int
    let expenses: ExpensesList
}

struct Expenses: Codable {
    let savedAmount: Int
    let expenses: [ExpensesList]
}

struct ExpensesList: Codable {
    let id: Int
    let amount: Int
    let content: String
    let category: String
    let savedAmount: Int
}

extension Expenses {
    static let emtpyExpenses = Expenses(savedAmount: 0, expenses: [])
    
    static let testExpenses = Expenses(savedAmount: 15000,
                                       expenses: [ExpensesList(id: 0, amount: 1000, content: "테스트1", category: "MEAL", savedAmount: 1000),
                                                  ExpensesList(id: 1, amount: 14000, content: "테스트2", category: "CAFE_SNACK", savedAmount: 15000)])
}

extension ExpensesList {
    static func mapCategory(_ value: String) -> String {
        switch value {
        case "MEAL":
            return "식사"
        case "CAFE_SNACK":
            return "카페/간식"
        case "DRINK_ENTERTAINMENT":
            return "술/유흥"
        case "CONVENIENCE_STORE":
            return "편의점"
        case "CLOTHING":
            return "의류"
        case "BEAUTY":
            return "미용"
        case "CULTURE_HOBBY":
            return "문화/취미"
        case "LIVING":
            return "생활"
        case "TRAVEL_ACCOMMODATION":
            return "여행/숙박"
        case "TRANSPORTATION":
            return "교통"
        case "MEDICAL_HEALTH":
            return "의료/건강"
        case "EDUCATION":
            return "교육"
        case "COMMUNICATION":
            return "통신"
        case "MEMBERSHIP_FEE":
            return "회비"
        case "FAMILY_OCCASION":
            return "경조사"
        case "MISC":
            return "기타"
        default:
            return value
        }
    }

    static func mapCategoryImage(_ value: String) -> String {
        switch value {
        case "MEAL":
            return "🍽️"
        case "CAFE_SNACK":
            return "☕️"
        case "DRINK_ENTERTAINMENT":
            return "🍻"
        case "CONVENIENCE_STORE":
            return "🏪"
        case "CLOTHING":
            return "👕"
        case "BEAUTY":
            return "🛁"
        case "CULTURE_HOBBY":
            return "🎶"
        case "LIVING":
            return "🛒"
        case "TRAVEL_ACCOMMODATION":
            return "✈️"
        case "TRANSPORTATION":
            return "🚃"
        case "MEDICAL_HEALTH":
            return "🏥"
        case "EDUCATION":
            return "🎓"
        case "COMMUNICATION":
            return "📱"
        case "MEMBERSHIP_FEE":
            return "👨‍👧‍👦"
        case "FAMILY_OCCASION":
            return "✉️"
        case "MISC":
            return "💬"
        default:
            return value
        }
    }
}
