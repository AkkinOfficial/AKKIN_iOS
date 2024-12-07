//
//  AppLaunchManager.swift
//  AKKIN
//
//  Created by 신종원 on 11/24/24.
//

import Foundation

final class AppLaunchManager {
    static func isFirstLaunch() -> Bool {
        let hasLaunchedBefore = UserDefaults.standard.bool(forKey: "HasLaunchedBefore")
        if hasLaunchedBefore {
            return false
        } else {
            UserDefaults.standard.set(true, forKey: "HasLaunchedBefore")
            return true
        }
    }
}
