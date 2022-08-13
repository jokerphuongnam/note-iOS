//
//  LoginUseCase.swift
//  NotesManager
//
//  Created by pnam on 11/08/2022.
//

@_implementationOnly import RxSwift

protocol LoginUseCase {
    func login(email: String, password: String) -> Completable
    func updatePasswordInLocal(email: String, password: String) -> Completable
}

final class LoginUseCaseImpl: LoginUseCase {
    var userRepository: UserRepository!
    
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    deinit {
        userRepository = nil
    }
    
    func login(email: String, password: String) -> Completable {
        userRepository.login(email: email, password: password)
            .subscribe(on: SerialDispatchQueueScheduler.init(qos: .utility))
            .observe(on: MainScheduler.instance)
    }
    
    func updatePasswordInLocal(email: String, password: String) -> Completable {
        userRepository.updatePasswordInLocal(email: email, password: password)
            .subscribe(on: SerialDispatchQueueScheduler.init(qos: .utility))
            .observe(on: MainScheduler.instance)
    }
}
