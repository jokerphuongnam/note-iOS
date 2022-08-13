//
//  UserRepository.swift
//  NotesManager
//
//  Created by pnam on 11/08/2022.
//

@_implementationOnly import RxSwift

protocol UserRepository {
    var emails: [String] { get }
    func login(email: String, password: String) -> Completable
    func deleteEmail(email: String)
    func updatePasswordInLocal(email: String, password: String) -> Completable
    func getLogin(email: String) throws -> Login
}

final class UserRepositoryImpl: UserRepository {
    var network: UserNetwork!
    var local: UserLocal!
    
    var emails: [String] {
        local.emails
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
                return self.local.login(email: email, password: password, user: loginResponse.user, token: loginResponse.token)
            }
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
}
