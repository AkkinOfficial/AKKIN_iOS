//
//  Category.swift
//  AKKIN
//
//  Created by 박지윤 on 8/15/24.
//

enum CategoryMapper {
    static func mapCategory(_ value: String) -> String {
        switch value {
        case "MEAL": return "식사"
        case "CAFE_SNACK": return "카페/간식"
        case "DRINK_ENTERTAINMENT": return "술/유흥"
        case "CONVENIENCE_STORE": return "편의점"
        case "CLOTHING": return "의류"
        case "BEAUTY": return "미용"
        case "CULTURE_HOBBY": return "문화/취미"
        case "LIVING": return "생활"
        case "TRAVEL_ACCOMMODATION": return "여행/숙박"
        case "TRANSPORTATION": return "교통"
        case "MEDICAL_HEALTH": return "의료/건강"
        case "EDUCATION": return "교육"
        case "COMMUNICATION": return "통신"
        case "MEMBERSHIP_FEE": return "회비"
        case "FAMILY_OCCASION": return "경조사"
        case "MISC": return "기타"
        default: return value
        }
    }

    static func mapCategoryImage(_ value: String) -> String {
        switch value {
        case "MEAL": return "🍽️"
        case "CAFE_SNACK": return "☕️"
        case "DRINK_ENTERTAINMENT": return "🍻"
        case "CONVENIENCE_STORE": return "🏪"
        case "CLOTHING": return "👕"
        case "BEAUTY": return "🛁"
        case "CULTURE_HOBBY": return "🎶"
        case "LIVING": return "🛒"
        case "TRAVEL_ACCOMMODATION": return "✈️"
        case "TRANSPORTATION": return "🚃"
        case "MEDICAL_HEALTH": return "🏥"
        case "EDUCATION": return "🎓"
        case "COMMUNICATION": return "📱"
        case "MEMBERSHIP_FEE": return "👨‍👧‍👦"
        case "FAMILY_OCCASION": return "✉️"
        case "MISC": return "💬"
        default: return value
        }
    }
}
