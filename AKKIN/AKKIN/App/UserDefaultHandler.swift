//
//  UserDefaultHandler.swift
//  AKKIN
//
//  Created by 박지윤 on 2023/09/26.
//

struct UserDefaultHandler {
    @UserDefault(key: "accessToken", defaultValue: "")
    static var accessToken: String
    
    @UserDefault(key: "refreshToken", defaultValue: "")
    static var refreshToken: String

//    static var accessToken: String? {
//        get {
//            return KeychainManager.getData(key: "accessToken")
//        }
//        set {
//            guard let newValue = newValue else { return }
//            KeychainManager.saveData(newValue, key: "accessToken")
//        }
//    }
//
//    static var refreshToken: String? {
//        get {
//            return KeychainManager.getData(key: "refreshToken")
//        }
//        set {
//            guard let newValue = newValue else { return }
//            KeychainManager.saveData(newValue, key: "refreshToken")
//        }
//    }

    @UserDefault(key: "appleToken", defaultValue: "")
    static var appleToken: String

    @UserDefault(key: "authorizationCode", defaultValue: "")
    static var authorizationCode: String

    @UserDefault(key: "userEmail", defaultValue: "")
    static var userEmail: String
}
