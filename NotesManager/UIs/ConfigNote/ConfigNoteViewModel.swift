//
//  ConfigNoteViewModel.swift
//  NotesManager
//
//  Created by pnam on 06/08/2022.
//

@_implementationOnly import UIKit

protocol ConfigNoteViewModel {
    var note: Note { get set }
    var title: String { get }
}

final class ConfigNoteViewModelImpl: ConfigNoteViewModel {
    var note: Note
    var title: String
    
    init(note: Note? = nil) {
        if let note = note {
            self.note = note
            self.title = Strings.addNote
        } else {
            self.note = .init(id: "", title: "", description: "", color: UIColor.white, createAt: 0, updateAt: 0)
            self.title = Strings.editNote
        }
    }
}
