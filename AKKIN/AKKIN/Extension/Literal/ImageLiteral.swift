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
    public static var emptyBill: UIImage { .load(name: "empty_bill")}
}

public enum AkkinButton {
    public static var addButton: UIImage { .load(name: "add_button") }
    public static var backButton: UIImage { .load(name: "back_button") }
    public static var closeButton: UIImage { .load(name: "close_button") }
    public static var detailButton: UIImage { .load(name: "detail_button") }
    public static var editButton: UIImage { .load(name: "edit_button") }
    public static var nextButton: UIImage { .load(name: "next_button") }
    public static var previousButton: UIImage { .load(name: "previous_button") }
    public static var skipButton: UIImage { .load(name: "skipButton") }
    public static var kebabButton: UIImage { .load(name: "kebab_button") }
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
    public static var miniCalendar: UIImage { .load(name: "ic_miniCalendar") }
    public static var tag: UIImage { .load(name: "ic_tag") }
    public static var wallet: UIImage { .load(name: "ic_wallet") }
    public static var bookmark: UIImage { .load(name: "ic_bookmark") }
    public static var memo: UIImage { .load(name: "ic_memo") }
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
