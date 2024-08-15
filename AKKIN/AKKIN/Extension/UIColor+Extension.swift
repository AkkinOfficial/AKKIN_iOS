//
//  UIColor+Extension.swift
//  AKKIN
//
//  Created by SJW on 2023/09/19.
//

import UIKit

extension UIColor {
    /// akkin main color
    static var akkinGreen: UIColor {
        return UIColor(hex: "#23AD5F")
    }

    /// akkin basic color
    static var akkinBlack: UIColor {
        return UIColor(hex: "#19191B")
    }
    static var akkinWhite: UIColor {
        return UIColor(hex: "#FFFFFF")
    }

    /// akkin background color
    static var akkinBG: UIColor {
        return UIColor(hex: "#F2F4F5")
    }

    /// akkin background color
    static var akkinGray1: UIColor {
        return UIColor(hex: "#151515", alpha: 0.15)
    }

    /// akkin textColor color
    static var akkinGray2: UIColor {
        return UIColor(hex: "#B0B0B0")
    }

    /// akkin border color
    static var akkinGray3: UIColor {
        return UIColor(hex: "#E5E5E5")
    }

    /// akkin empty text color
    static var akkinGray4: UIColor {
        return UIColor(hex: "#C5C5C5")
    }

    /// akkin tabBar default color
    static var akkinGray5: UIColor {
        return UIColor(hex: "#B0B8C1")
    }

    /// akkin analysis color
    static var akkinAnalysisDefault: UIColor {
        return UIColor(hex: "#D4D7DA")
    }

    static var akkinAnalysisRed: UIColor {
        return UIColor(hex: "#EF4352")
    }

    static var akkinAnalysisGray: UIColor {
        return UIColor(hex: "#687680")
    }

    static var akkinAnalysisBlue: UIColor {
        return UIColor(hex: "#3182F6")
    }

    static var akkinAnalysisPink: UIColor {
        return UIColor(hex: "#DA9BEF")
    }

    static var akkinAnalysisGreen: UIColor {
        return UIColor(hex: "#02AF6C")
    }
}

extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexFormatted: String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()

        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }

        assert(hexFormatted.count == 6, "Invalid hex code used.")
        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)

        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0, alpha: alpha)
    }
}
