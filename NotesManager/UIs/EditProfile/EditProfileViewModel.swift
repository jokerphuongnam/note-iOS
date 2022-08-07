//
//  EditProfileViewModel.swift
//  NotesManager
//
//  Created by pnam on 07/08/2022.
//

import Foundation

protocol EditProfileViewModel {
    var user: User { get set }
}

final class EditProfileViewModelImpl: EditProfileViewModel {
    var user: User
    
    init(user: User) {
        self.user = user
    }
}
