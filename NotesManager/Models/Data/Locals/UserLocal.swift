//
//  UserLocal.swift
//  NotesManager
//
//  Created by pnam on 11/08/2022.
//

@_implementationOnly import RealmSwift
@_implementationOnly import RxSwift

protocol UserLocal {
    var user: User? { get set }
    func login(email: String, password: String, user: User, token: String) -> Completable
}

final class UserLocalImpl: UserLocal {
    private static let account = "account"
    
    private var keyChainManager: KeyChainManager!
    private var userDefaultsManager: UserDefaultsManager!
    
    var user: User? {
        get {
            userDefaultsManager.user
        }
        set {
            userDefaultsManager.user = newValue
        }
    }
    
    init(keyChainManager: KeyChainManager, userDefaultsManager: UserDefaultsManager) {
        self.keyChainManager = keyChainManager
        self.userDefaultsManager = userDefaultsManager
    }
    
    deinit {
        keyChainManager = nil
        userDefaultsManager = nil
    }
    
    func login(email: String, password: String, user: User, token: String) -> Completable {
        let lowercasedEmail = email.lowercased()
        return userDefaultsManager.saveUser(user: user)
            .andThen(userDefaultsManager.login(email: email, password: password))
            .andThen(keyChainManager.saveAccount(email: lowercasedEmail, password: password))
            .andThen(keyChainManager.saveToken(token: token))
            .catch { error in
                if case KeyChainError.duplicateEntry = error {
                    throw UserLocalError.duplicate
                }
                if case UserDefaultsError.duplicate = error {
                    throw UserLocalError.duplicate
                }
                throw error
            }
    }
}

extension UserLocalImpl {
    enum UserLocalError: Error {
        case duplicate
    }
}

typealias UserLocalError = UserLocalImpl.UserLocalError
