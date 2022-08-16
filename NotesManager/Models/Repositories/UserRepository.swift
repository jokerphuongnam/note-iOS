//
//  UserRepository.swift
//  NotesManager
//
//  Created by pnam on 11/08/2022.
//

@_implementationOnly import RxSwift

protocol UserRepository {
    var emails: [String] { get }
    var user: User? { get set }
    func login(email: String, password: String) -> Completable
    func register(email: String, password: String) -> Completable
    func deleteEmail(email: String)
    func updatePasswordInLocal(email: String, password: String) -> Completable
    func getLogin(email: String) throws -> Login
    func changePassword(oldPassword:String, newPassword: String) -> Completable
    func editProfile(user: User!) -> Completable
    func logout()
}

final class UserRepositoryImpl: UserRepository {
    private var network: UserNetwork!
    private var local: UserLocal!
    
    var emails: [String] {
        local.emails
    }
    
    var user: User? {
        get {
            local.user
        }
        set {
            local.user = newValue
        }
    }
    
    init(network: UserNetwork, local: UserLocal) {
        self.network = network
        self.local = local
    }
    
    deinit {
        network = nil
        local = nil
    }
    
    func login(email: String, password: String) -> Completable {
        network.login(email: email, password: password)
            .flatMapCompletable { [weak self] loginResponse in
                guard let self = self else {
                    throw NError.ownerNil
                }
                try self.local.saveLoginToken(token: loginResponse.token)
                return self.local.login(email: email, password: password, user: loginResponse.user, token: loginResponse.token)
            }
    }
    
    func register(email: String, password: String) -> Completable {
        network.register(email: email, password: email)
            .asCompletable()
    }
    
    func deleteEmail(email: String) {
        local.deleteEmail(email: email)
    }
    
    func updatePasswordInLocal(email: String, password: String) -> Completable {
        local.updatePasswordInLocal(email: email, password: password)
    }
    
    func getLogin(email: String) throws -> Login {
        try local.getLogin(email: email)
    }
    
    func changePassword(oldPassword: String, newPassword: String) -> Completable {
        network.changePassword(oldPassword: oldPassword, newPassword: newPassword)
            .asCompletable()
    }
    
    func editProfile(user: User!) -> Completable {
        let editProfileCompletable: Single<UpdateProfileRequest.Response>
        if let user = user {
            editProfileCompletable = network.updateProfile(name: user.name, gender: user.gender.constant)
        } else {
            editProfileCompletable = network.updateProfile(name: nil, gender: nil)
        }
        return editProfileCompletable
            .map { [weak self] response -> Void in
                guard let self = self else {
                    return ()
                }
                self.local.user = response.user
                return ()
            }
            .asCompletable()
    }
    
    func logout() {
        local.logout()
    }
}
