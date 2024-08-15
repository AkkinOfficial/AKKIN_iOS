//
//  ImageLiteral.swift
//  AKKIN
//
//  Created by 박지윤 on 2023/09/26.
//

import UIKit

public enum AkkinImage {
    public static var akkinlogin: UIImage { .load(name: "login")}
    public static var akkinOnboarding1: UIImage { .load(name: "onboarding1")}
    public static var akkinOnboarding2: UIImage { .load(name: "onboarding2")}
    public static var akkinOnboarding3: UIImage { .load(name: "onboarding3")}
    public static var akkinSplash: UIImage { .load(name: "splash")}
}

public enum AkkinButton {
    public static var addButton: UIImage { .load(name: "add_button") }
    public static var backButton: UIImage { .load(name: "backButton") }
    public static var detailButton: UIImage { .load(name: "detail_button") }
    public static var skipButton: UIImage { .load(name: "skipButton") }
}

public enum AkkinIcon {
    public static var home: UIImage { .load(name: "ic_home") }
    public static var homeFilled: UIImage { .load(name: "ic_homeFilled") }
    public static var habit: UIImage { .load(name: "ic_habit") }
    public static var habitFilled: UIImage { .load(name: "ic_habitFilled") }
    public static var calendar: UIImage { .load(name: "ic_calendar") }
    public static var calendarFilled: UIImage { .load(name: "ic_calendarFilled") }
    public static var my: UIImage { .load(name: "ic_my") }
    public static var myFilled: UIImage { .load(name: "ic_myFilled") }
}

extension UIImage {
    static func load(name: String) -> UIImage {
        guard let image = UIImage(named: name, in: nil, compatibleWith: nil) else {
            return UIImage()
        }
        image.accessibilityIdentifier = name
        return image
    }
}
