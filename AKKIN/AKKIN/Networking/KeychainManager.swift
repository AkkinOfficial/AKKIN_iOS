//
//  KeychainManager.swift
//  AKKIN
//
//  Created by 신종원 on 11/16/24.
//

import Foundation
import Security

final class KeychainManager {
    static let shared = KeychainManager()
    private init() {}

    /// 데이터 저장
    @discardableResult
    func save(key: String, value: String) -> Bool {
        guard let data = value.data(using: .utf8) else { return false }

        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecValueData as String: data
        ]

        // 기존 데이터 삭제
        SecItemDelete(query as CFDictionary)

        // 새 데이터 저장
        let status = SecItemAdd(query as CFDictionary, nil)
        if status != errSecSuccess {
            print("❌ Keychain Save Error: \(status)")
        }
        return status == errSecSuccess
    }

    /// 데이터 읽기
    func load(key: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]

        var data: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &data)

        if status == errSecSuccess, let retrievedData = data as? Data {
            return String(data: retrievedData, encoding: .utf8)
        } else {
            print("❌ Keychain Load Error: \(status)")
            return nil
        }
    }

    /// 데이터 삭제
    @discardableResult
    func delete(key: String) -> Bool {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key
        ]

        let status = SecItemDelete(query as CFDictionary)
        if status != errSecSuccess {
            print("❌ Keychain Delete Error: \(status)")
        }
        return status == errSecSuccess
    }

    // Keychain 초기화
        func resetKeychain() {
            let secItemClasses = [
                kSecClassGenericPassword,
                kSecClassInternetPassword,
                kSecClassCertificate,
                kSecClassKey,
                kSecClassIdentity
            ]

            for itemClass in secItemClasses {
                let query: [String: Any] = [kSecClass as String: itemClass]
                SecItemDelete(query as CFDictionary)
            }

            print("🔑 Keychain has been reset.")
        }

    /// Keychain 상태 확인
    func checkStatus(for key: String) -> Bool {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnAttributes as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]

        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        return status == errSecSuccess
    }
}
