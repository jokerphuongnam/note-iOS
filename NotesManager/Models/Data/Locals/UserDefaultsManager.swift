//
//  UserDefaultsManager.swift
//  NotesManager
//
//  Created by pnam on 12/08/2022.
//

@_implementationOnly import RxSwift

protocol UserDefaultsManager {
    var user: User? { get set }
    var accessToken: String? { get set }
    var emails: [String] { get }
    func login(email: String, password: String) -> Completable
    func deleteEmail(email: String)
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
    
    var accessToken: String? {
        get {
            userDefaults.string(forKey: .userDefaultAccessToken) ?? ""
        }
        set {
            userDefaults.set(newValue, forKey: .userDefaultAccessToken)
            userDefaults.synchronize()
        }
    }
    
    var emails: [String] {
        userDefaults.stringArray(forKey: .userDefaultAccount) ?? []
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
                return Disposables.create()
            }
            
            var accounts = self.userDefaults.stringArray(forKey: .userDefaultAccount) ?? []
            if !accounts.contains(email) {
                accounts.append(email)
                self.userDefaults.set(accounts, forKey: .userDefaultAccount)
                self.userDefaults.synchronize()
            }
            observer(.completed)
            return Disposables.create()
        }
    }
    
    func deleteEmail(email: String) {
        let accounts = userDefaults.stringArray(forKey: .userDefaultAccount) ?? []
        userDefaults.set(accounts.filter { $0 != email }, forKey: .userDefaultAccount)
        userDefaults.synchronize()
    }
    
    func saveUser(user: User) -> Completable {
        .create { [weak self] observer in
            guard let self = self else {
                observer(.error(NError.ownerNil))
                return Disposables.create ()
            }
            self.user = user
            observer(.completed)
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
        case notFound
    }
}

typealias UserDefaultsError = UserDefaultsManagerImpl.UserDefaultsError
private typealias UserUserDefaults = (id: String, email: String, name: String, gender: String)
