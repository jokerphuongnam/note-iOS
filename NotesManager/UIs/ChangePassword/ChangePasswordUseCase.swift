//
//  ChangePasswordUseCase.swift
//  NotesManager
//
//  Created by pnam on 16/08/2022.
//

@_implementationOnly import RxSwift

protocol ChangePasswordUseCase {
    func changePassword(oldPassword:String, newPassword: String) -> Completable
}

final class ChangePasswordUseCaseImpl: ChangePasswordUseCase {
    private var userRepository: UserRepository!
    
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    deinit {
        userRepository = nil
    }
    
    func changePassword(oldPassword: String, newPassword: String) -> Completable {
        userRepository.changePassword(oldPassword: oldPassword, newPassword: newPassword)
            .subscribe(on: SerialDispatchQueueScheduler.init(qos: .utility))
            .observe(on: MainScheduler.instance)
    }
}
