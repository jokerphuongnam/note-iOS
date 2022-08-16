//
//  ChangePasswordViewModel.swift
//  NotesManager
//
//  Created by pnam on 07/08/2022.
//

@_implementationOnly import RxSwift

protocol ChangePasswordViewModel {
    func changePassword(oldPassword:String, newPassword: String) -> Completable
}

final class ChangePasswordViewModelImpl: ChangePasswordViewModel {
    private var useCase: ChangePasswordUseCase!
    
    init(useCase: ChangePasswordUseCase) {
        self.useCase = useCase
    }
    
    deinit {
        useCase = nil
    }
    
    func changePassword(oldPassword: String, newPassword: String) -> Completable {
        useCase.changePassword(oldPassword: oldPassword, newPassword: newPassword)
    }
}
