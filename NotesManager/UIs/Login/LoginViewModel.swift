//
//  LoginViewModel.swift
//  NotesManager
//
//  Created by pnam on 11/08/2022.
//

@_implementationOnly import RxSwift
@_implementationOnly import RxCocoa

protocol LoginViewModel {
    var emailsRecommendsObserver: BehaviorRelay<[String]> { get }
    var emailsRecommend: [String] { get }
    func login(email: String, password: String) -> Completable
    func deleteEmailRecommend(email: String)
    func updatePasswordInLocal(email: String, password: String) -> Completable
    func getEmailsRecommend(searchWords: String)
    func getLogin(email: String) throws -> Login
}

final class LoginViewModelImpl: LoginViewModel {
    private var useCase: LoginUseCase!
    
    var emailsRecommendsObserver: BehaviorRelay<[String]> = BehaviorRelay(value: [])
    
    var emailsRecommend: [String] {
        emailsRecommendsObserver.value
    }
    
    init(useCase: LoginUseCase) {
        self.useCase = useCase
    }
    
    deinit {
        useCase = nil
    }
    
    func login(email: String, password: String) -> Completable {
        useCase.login(email: email, password: password)
    }
    
    func deleteEmailRecommend(email: String) {
        useCase.deleteEmail(email: email)
    }
    
    func updatePasswordInLocal(email: String, password: String) -> Completable {
        useCase.updatePasswordInLocal(email: email, password: password)
    }
    
    func getEmailsRecommend(searchWords: String) {
        let emails = useCase.emails
        if searchWords.isEmpty {
            emailsRecommendsObserver.accept(emails)
        } else {
            emailsRecommendsObserver.accept(
                emails.filter { e in
                    e.contains(searchWords)
                }
            )
        }
    }
    
    func getLogin(email: String) throws -> Login {
        try useCase.getLogin(email: email)
    }
}
