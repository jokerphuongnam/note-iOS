//
//  UserRepository.swift
//  NotesManager
//
//  Created by pnam on 11/08/2022.
//

@_implementationOnly import RxSwift

protocol UserRepository {
    func login(email: String, password: String) -> Completable
}

final class UserRepositoryImpl: UserRepository {
    var network: UserNetwork!
    var local: UserLocal!
    
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
}
