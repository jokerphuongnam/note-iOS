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
    func updatePasswordInLocal(email: String, password: String) -> Completable
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
            .andThen(.create { [weak self] observer in
                guard let self = self else {
                    observer(.error(NError.ownerNil))
                    return Disposables.create()
                }
                do {
                    try self.keyChainManager.saveAccount(email: lowercasedEmail, password: password)
                    observer(.completed)
                } catch {
                    observer(.error(error))
                }
                return Disposables.create()
            })
            .andThen(.create { [weak self] observer in
                guard let self = self else {
                    observer(.error(NError.ownerNil))
                    return Disposables.create()
                }
                do {
                    try self.keyChainManager.saveToken(token: token)
                    observer(.completed)
                } catch {
                    observer(.error(error))
                }
                return Disposables.create()
            })
            .catch { [weak self] error in
                guard let self = self else { throw NError.ownerNil }
                if case KeyChainError.duplicateEntry = error {
                    if let keyChainPassword = try? self.keyChainManager.getAccount(email: email), keyChainPassword != password {
                        throw UserLocalError.duplicate
                    } else {
                        return Completable.empty()
                    }
                }
                throw error
            }
    }
    
    func updatePasswordInLocal(email: String, password: String) -> Completable {
        .create { [weak self] observer in
            guard let self = self else {
                observer(.error(NError.ownerNil))
                return Disposables.create()
            }
            do {
                try self.keyChainManager.updateAccount(email: email, password: password)
                observer(.completed)
            } catch {
                observer(.error(error))
            }
            return Disposables.create()
        }
    }
}

extension UserLocalImpl {
    enum UserLocalError: Error {
        case duplicate
    }
}

typealias UserLocalError = UserLocalImpl.UserLocalError
