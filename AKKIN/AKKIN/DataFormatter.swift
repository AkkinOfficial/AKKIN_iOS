//
//  DataFormatter.swift
//  AKKIN
//
//  Created by 박지윤 on 11/30/24.
//

import UIKit

extension DateFormatter {
    static func localizedStringToDate(_ dateString: String, format: String = "yyyy-MM-dd") -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.date(from: dateString)
    }

    static func formatDateToString(_ date: Date, _ format: String) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
}
