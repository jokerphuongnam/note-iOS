//
//  UserDefaultsManager.swift
//  NotesManager
//
//  Created by pnam on 12/08/2022.
//

@_implementationOnly import RxSwift

protocol UserDefaultsManager {
    var user: User? { get set }
    func login(email: String, password: String) -> Completable
    func saveUser(user: User) -> Completable
    func getUser() -> Single<User>
}

final class UserDefaultsManagerImpl: UserDefaultsManager {
    var userDefaults: UserDefaults!
    var decoder: JSONDecoder!
    var encoder: JSONEncoder!
    
    var user: User? {
        get {
            guard let data = userDefaults.object(forKey: .userDefaultUser) as? Data, let user = try? decoder.decode(User.self, from: data) else {
                return nil
            }
            return user
        }
        set {
            if let value = newValue, let data = try? encoder.encode(value) {
                userDefaults.set(data, forKey: .userDefaultUser)
            }
            userDefaults.synchronize()
        }
    }
    
    init(userDefaults: UserDefaults, decoder: JSONDecoder, encoder: JSONEncoder) {
        self.userDefaults = userDefaults
        self.decoder = decoder
        self.encoder = encoder
    }
    
    deinit {
        userDefaults = nil
        decoder = nil
        encoder = nil
    }
    
    func login(email: String, password: String) -> Completable {
        .create { [weak self] observer in
            guard let self = self else {
                observer(.error(NError.ownerNil))
                return Disposables.create {
                    
                }
            }
            let accounts = self.userDefaults.stringArray(forKey: .userDefaultAccount)
            if var accounts = accounts, !accounts.contains(email) {
                accounts.append(email)
                self.userDefaults.set(accounts, forKey: .userDefaultAccount)
                self.userDefaults.synchronize()
            } else {
                observer(.error(UserDefaultsError.duplicate))
            }
            observer(.completed)
            return Disposables.create()
        }
    }
    
    func saveUser(user: User) -> Completable {
        .create { [weak self] observer in
            guard let self = self else {
                observer(.error(NError.ownerNil))
                return Disposables.create ()
            }
            self.user = user
            return Disposables.create()
        }
    }
    
    func getUser() -> Single<User> {
        .create { [weak self] observer in
            guard let self = self else {
                observer(.failure(NError.ownerNil))
                return Disposables.create ()
            }
            if let user = self.user {
                observer(.success(user))
            } else {
                observer(.failure(UserDefaultsError.notFound))
            }
            return Disposables.create()
        }
    }
}

extension UserDefaultsManagerImpl {
    enum UserDefaultsError: Error {
        case duplicate
        case notFound
    }
}

typealias UserDefaultsError = UserDefaultsManagerImpl.UserDefaultsError
private typealias UserUserDefaults = (id: String, email: String, name: String, gender: String)
