//
//  SettingUseCase.swift
//  NotesManager
//
//  Created by pnam on 16/08/2022.
//

import Foundation

protocol SettingUseCase: AnyObject {
    var user: User? { get }
    func logout()
}

final class SettingUseCaseImpl: SettingUseCase {
    private var userRepository: UserRepository!
    private var noteRepository: NoteRepository!
    
    var user: User? {
        userRepository.user
    }
    
    init(userRepository: UserRepository, noteRepository: NoteRepository) {
        self.userRepository = userRepository
        self.noteRepository = noteRepository
    }
    
    deinit {
        userRepository = nil
        noteRepository = nil
    }
    
    func logout() {
        userRepository.logout()
    }
}
