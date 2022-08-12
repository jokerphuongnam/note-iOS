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
    @discardableResult
    func saveToken(token: String) -> Completable
    @discardableResult
    func getToken() -> Single<String>
    @discardableResult
    func updateToken(token: String) -> Completable
    
    @discardableResult
    func saveAccount(email: String, password: String) -> Completable
    @discardableResult
    func getAccount(email: String) -> Single<String>
    @discardableResult
    func updateAccount(email: String, password: String) -> Completable
    @discardableResult
    func deleteAccount(email: String) -> Completable
}

final class KeyChainManagerImpl: KeyChainManager {
    @discardableResult
    func saveToken(token: String) -> Completable {
        save(type: .token, account: KeyChainServiceType.token.rawValue, value: token)
    }
    
    @discardableResult
    func getToken() -> Single<String> {
        get(type: .token, account: KeyChainServiceType.token.rawValue)
    }
    
    @discardableResult
    func updateToken(token: String) -> Completable {
        update(type: .token, account: KeyChainServiceType.token.rawValue, value: token)
    }
    
    @discardableResult
    func saveAccount(email: String, password: String) -> Completable {
        save(type: .login, account: email, value: password)
    }
    
    @discardableResult
    func getAccount(email: String) -> Single<String> {
        get(type: .login, account: email)
    }
    
    @discardableResult
    func updateAccount(email: String, password: String) -> Completable {
        update(type: .login, account: email, value: password)
    }
    
    @discardableResult
    func deleteAccount(email: String) -> Completable {
        delete(type: .login, account: email)
    }
}

private extension KeyChainManagerImpl {
    @discardableResult
    private func save(type: KeyChainServiceType, account: String, value: String) -> Completable {
        .create { observer in
            let query: [String: AnyObject] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrService as String: type as AnyObject,
                kSecAttrAccount as String: account as AnyObject,
                kSecValueData as String: value.data(using: .utf8) as AnyObject
            ]
            let status = SecItemAdd(query as CFDictionary, nil)
            
            if status == errSecDuplicateItem {
                observer(.error(KeyChainError.duplicateEntry))
                return Disposables.create()
            }
            guard status == errSecSuccess else {
                observer(.error(KeyChainError.unknown(status)))
                return Disposables.create()
            }
            observer(.completed)
            return Disposables.create()
        }
    }
    
    @discardableResult
    func get(type: KeyChainServiceType, account: String) -> Single<String> {
        .create { observer in
            let query: [String: AnyObject] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrService as String: type as AnyObject,
                kSecAttrAccount as String: account as AnyObject,
                kSecReturnData as String: kCFBooleanTrue,
                kSecMatchLimit as String: kSecMatchLimitOne
            ]
            
            var result: AnyObject? = nil
            SecItemCopyMatching(query as CFDictionary, &result)
            guard let data: Data = result as? Data else {
                observer(.failure(NError.canNotConvertObject))
                return Disposables.create()
            }
            
            observer(.success(String(decoding: data, as: UTF8.self)))
            return Disposables.create()
        }
    }
    
    @discardableResult
    func delete(type: KeyChainServiceType, account: String) -> Completable {
        .create { observer in
            let query: [String: AnyObject] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrService as String: type as AnyObject,
                kSecAttrAccount as String: account as AnyObject
            ]
            
            let status = SecItemDelete(query as CFDictionary)
            
            if status == errSecDuplicateItem {
                observer(.error(KeyChainError.duplicateEntry))
                return Disposables.create()
            }
            guard status == errSecSuccess else {
                observer(.error(KeyChainError.unknown(status)))
                return Disposables.create()
            }
            observer(.completed)
            return Disposables.create()
        }
    }
    
    @discardableResult
    private func update(type: KeyChainServiceType, account: String, value: String) -> Completable {
        .create { observer in
            let query: [String: AnyObject] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrService as String: type as AnyObject,
                kSecAttrAccount as String: account as AnyObject
            ]
            
            let attributes: [String: Any] = [
                kSecAttrAccount as String: account,
                kSecValueData as String: value
            ]
            
            let status = SecItemUpdate(query as CFDictionary, attributes as CFDictionary)
            
            if status == errSecDuplicateItem {
                observer(.error(KeyChainError.duplicateEntry))
                return Disposables.create()
            }
            guard status == errSecSuccess else {
                observer(.error(KeyChainError.unknown(status)))
                return Disposables.create()
            }
            observer(.completed)
            return Disposables.create()
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
        case unknown(OSStatus)
    }
}

typealias KeyChainError = KeyChainManagerImpl.KeyChainError
