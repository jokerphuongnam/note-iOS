//
//  EditProfileUseCase.swift
//  NotesManager
//
//  Created by pnam on 16/08/2022.
//

@_implementationOnly import RxSwift

protocol EditProfileUseCase {
    var user: User! { get set }
    func editProfile(user: User!) -> Completable
}

final class EditProfileUseCaseImpl: EditProfileUseCase {
    private var userRepository: UserRepository!
    
    var user: User! {
        get {
            userRepository.user
        }
        set {
            userRepository.user = newValue
        }
    }
    
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    deinit {
        userRepository = nil
    }
    
    func editProfile(user: User!) -> Completable {
        userRepository.editProfile(user: user)
            .subscribe(on: SerialDispatchQueueScheduler.init(qos: .utility))
            .observe(on: MainScheduler.instance)
    }
}
