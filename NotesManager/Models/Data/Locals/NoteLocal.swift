//
//  NoteLocal.swift
//  NotesManager
//
//  Created by pnam on 15/08/2022.
//

import Foundation

protocol NoteLocal {
    var tempNoteWhenInsert: Note? { get set }
    func deleteTempNoteWhenInsert()
}

final class NoteLocalImpl: NoteLocal {
    private var userDefaultsManager: UserDefaultsManager!
    
    var tempNoteWhenInsert: Note? {
        get {
            userDefaultsManager.tempNoteWhenInsert
        }
        set {
            userDefaultsManager.tempNoteWhenInsert = newValue
        }
    }
    
    init(userDefaultsManager: UserDefaultsManager) {
        self.userDefaultsManager = userDefaultsManager
    }
    
    deinit {
        userDefaultsManager = nil
    }
    
    func deleteTempNoteWhenInsert() {
        userDefaultsManager.deleteTempNoteWhenInsert()
    }
}
