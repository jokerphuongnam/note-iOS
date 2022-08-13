//
//  KeyChainManager.swift
//  NotesManager
//
//  Created by pnam on 11/08/2022.
//

@_implementationOnly import RxSwift
@_implementationOnly import CoreFoundation
import Security

protocol KeyChainManager {
    func saveToken(token: String) throws
    func getToken() throws -> String
    func updateToken(token: String) throws
    
    func saveAccount(email: String, password: String) throws
    func getAccount(email: String) throws -> String
    func updateAccount(email: String, password: String) throws
    func deleteAccount(email: String) throws
}

final class KeyChainManagerImpl: KeyChainManager {
    func saveToken(token: String) throws {
        try save(type: .token, account: KeyChainServiceType.token.rawValue, value: token)
    }
    
    func getToken() throws -> String {
        try get(type: .token, account: KeyChainServiceType.token.rawValue)
    }
    
    func updateToken(token: String) throws {
        try update(type: .token, account: KeyChainServiceType.token.rawValue, value: token)
    }
    
    func saveAccount(email: String, password: String) throws {
        try save(type: .login, account: email, value: password)
    }
    
    @discardableResult
    func getAccount(email: String) throws -> String {
        try get(type: .login, account: email)
    }
    
    func updateAccount(email: String, password: String) throws {
        try update(type: .login, account: email, value: password)
    }
    
    func deleteAccount(email: String) throws {
        try delete(type: .login, account: email)
    }
}

private extension KeyChainManagerImpl {
    private func save(type: KeyChainServiceType, account: String, value: String) throws {
        let query: [String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: type.rawValue as AnyObject,
            kSecAttrAccount as String: account as AnyObject,
            kSecValueData as String: value.data(using: .utf8) as AnyObject
        ]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        
        if status == errSecDuplicateItem {
            throw KeyChainError.duplicateEntry
        }
        guard status == errSecSuccess else {
            if let error: String = SecCopyErrorMessageString(status, nil) as String? {
                throw KeyChainError.message(error)
            }
            throw KeyChainError.unknown(status)
        }
    }
    
    @discardableResult
    func get(type: KeyChainServiceType, account: String) throws -> String {
        let query: [String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: type.rawValue as AnyObject,
            kSecAttrAccount as String: account as AnyObject,
            kSecReturnData as String: kCFBooleanTrue,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var result: AnyObject? = nil
        SecItemCopyMatching(query as CFDictionary, &result)
        guard let data: Data = result as? Data else {
            throw NError.canNotConvertObject
        }
        return String(decoding: data, as: UTF8.self)
    }
    
    func delete(type: KeyChainServiceType, account: String) throws {
        let query: [String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: type.rawValue as AnyObject,
            kSecAttrAccount as String: account as AnyObject
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        
        if status == errSecDuplicateItem {
            throw KeyChainError.duplicateEntry
        }
        guard status == errSecSuccess else {
            if let error: String = SecCopyErrorMessageString(status, nil) as String? {
                throw KeyChainError.message(error)
            }
            throw KeyChainError.unknown(status)
        }
    }
    
    private func update(type: KeyChainServiceType, account: String, value: String) throws {
        let query: [String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: type.rawValue as AnyObject,
            kSecAttrAccount as String: account as AnyObject
        ]
        
        let attributes: [String: Any] = [
            kSecAttrAccount as String: account,
            kSecValueData as String: value
        ]
        
        let status = SecItemUpdate(query as CFDictionary, attributes as CFDictionary)
        
        guard status == errSecSuccess else {
            if let error: String = SecCopyErrorMessageString(status, nil) as String? {
                throw KeyChainError.message(error)
            }
            throw KeyChainError.unknown(status)
        }
    }
}

private extension KeyChainManagerImpl {
    enum KeyChainServiceType: String {
        case login
        case token
    }
}

extension KeyChainManagerImpl {
    enum KeyChainError: Error {
        case duplicateEntry
        case message(String)
        case unknown(OSStatus)
    }
}

typealias KeyChainError = KeyChainManagerImpl.KeyChainError
