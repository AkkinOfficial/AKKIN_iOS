//
//  Category.swift
//  AKKIN
//
//  Created by 박지윤 on 8/15/24.
//

enum Category {
    case dining
    case traffic
    case etc
    case cafe
    case hobby

    var categoryImageString: String {
        switch self {
        case .dining:
            return "🍽️"
        case .traffic:
            return "🚃"
        case .etc:
            return "💬"
        case .cafe:
            return "☕️"
        case .hobby:
            return "🎶"
        }
    }

    static func toImageString(_ categoryName: String) -> Category? {
        switch categoryName {
        case "식사":
            return .dining
        case "교통":
            return .traffic
        case "기타":
            return .etc
        case "카페/간식":
            return .cafe
        case "문화/취미":
            return .hobby
        default:
            return nil
        }
    }
}
