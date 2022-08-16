//
//  RegisterViewModel.swift
//  NotesManager
//
//  Created by pnam on 16/08/2022.
//

@_implementationOnly import RxSwift

protocol RegisterViewModel {
    func register(email: String, password: String) -> Completable
}

final class RegisterViewModelImpl: RegisterViewModel {
    private var useCase: RegisterUseCase!
    
    init(useCase: RegisterUseCase) {
        self.useCase = useCase
    }
    
    deinit {
        useCase = nil
    }
    
    func register(email: String, password: String) -> Completable {
        useCase.register(email: email, password: password)
    }
}
