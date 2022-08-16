//
//  EditProfileViewModel.swift
//  NotesManager
//
//  Created by pnam on 07/08/2022.
//

@_implementationOnly import RxSwift

protocol EditProfileViewModel {
    var user: User! { get set }
    func editProfile() -> Completable
}

final class EditProfileViewModelImpl: EditProfileViewModel {
    private var useCase: EditProfileUseCase!
    var user: User!
    
    init(useCase: EditProfileUseCase) {
        self.useCase = useCase
        self.user = useCase.user
    }
    
    deinit {
        useCase = nil
    }
    
    func editProfile() -> Completable {
        useCase.editProfile(user: user)
    }
}
