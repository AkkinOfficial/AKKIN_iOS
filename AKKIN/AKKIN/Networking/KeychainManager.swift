//
//  KeychainManager.swift
//  AKKIN
//
//  Created by 신종원 on 11/16/24.
//

import Foundation
import Security

class KeychainManager {

    static func saveData(_ data: String, key: String) -> Bool {
        guard let data = data.data(using: .utf8) else { return false }

        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecValueData as String: data
        ]

        // 기존에 값이 있는지 확인하고, 있으면 업데이트, 없으면 추가
        SecItemDelete(query as CFDictionary) // 먼저 기존 항목 삭제
        let status = SecItemAdd(query as CFDictionary, nil)

        return status == errSecSuccess
    }

    static func getData(key: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]

        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)

        if status == errSecSuccess, let data = result as? Data, let value = String(data: data, encoding: .utf8) {
            return value
        }

        return nil
    }

    static func deleteData(key: String) -> Bool {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key
        ]

        let status = SecItemDelete(query as CFDictionary)
        return status == errSecSuccess
    }
}
