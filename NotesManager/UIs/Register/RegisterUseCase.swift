//
//  RegisterUseCase.swift
//  NotesManager
//
//  Created by pnam on 16/08/2022.
//

@_implementationOnly import RxSwift

protocol RegisterUseCase {
    func register(email: String, password: String) -> Completable
}

final class RegisterUseCaseImpl: RegisterUseCase {
    private var userRepository: UserRepository!
    
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    deinit {
        userRepository = nil
    }
    
    func register(email: String, password: String) -> Completable {
        userRepository.register(email: email, password: password)
            .subscribe(on: SerialDispatchQueueScheduler.init(qos: .utility))
            .observe(on: MainScheduler.instance)
    }
}
