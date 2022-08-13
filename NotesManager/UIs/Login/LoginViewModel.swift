//
//  LoginViewModel.swift
//  NotesManager
//
//  Created by pnam on 11/08/2022.
//

@_implementationOnly import RxSwift

protocol LoginViewModel {
    func login(email: String, password: String) -> Completable
    func updatePasswordInLocal(email: String, password: String) -> Completable
}

final class LoginViewModelImpl: LoginViewModel {
    private var useCase: LoginUseCase!
    
    init(useCase: LoginUseCase) {
        self.useCase = useCase
    }
    
    deinit {
        useCase = nil
    }
    
    func login(email: String, password: String) -> Completable {
        useCase.login(email: email, password: password)
    }
    
    func updatePasswordInLocal(email: String, password: String) -> Completable {
        useCase.updatePasswordInLocal(email: email, password: password)
    }
}
