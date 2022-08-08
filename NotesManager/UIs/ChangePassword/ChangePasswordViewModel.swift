//
//  ChangePasswordViewModel.swift
//  NotesManager
//
//  Created by pnam on 07/08/2022.
//

import Foundation

protocol ChangePasswordViewModel {
    var user: User { get set }
}

final class ChangePasswordViewModelImpl: ChangePasswordViewModel {
    var user: User
    
    init(user: User) {
        self.user = user
    }
}
