//
//  LoginUseCase.swift
//  NotesManager
//
//  Created by pnam on 11/08/2022.
//

@_implementationOnly import RxSwift

protocol LoginUseCase {
    var emails: [String] { get }
    func login(email: String, password: String) -> Completable
    func deleteEmail(email: String)
    func updatePasswordInLocal(email: String, password: String) -> Completable
    func getLogin(email: String) throws -> Login
}

final class LoginUseCaseImpl: LoginUseCase {
    private var userRepository: UserRepository!
    
    var emails: [String] {
        userRepository.emails
    }
    
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
    
    func deleteEmail(email: String) {
        userRepository.deleteEmail(email: email)
    }
    
    func updatePasswordInLocal(email: String, password: String) -> Completable {
        userRepository.updatePasswordInLocal(email: email, password: password)
            .subscribe(on: SerialDispatchQueueScheduler.init(qos: .utility))
            .observe(on: MainScheduler.instance)
    }
    
    func getLogin(email: String) throws -> Login {
        try userRepository.getLogin(email: email)
    }
}
