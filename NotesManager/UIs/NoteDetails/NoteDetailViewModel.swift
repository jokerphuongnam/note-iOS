//
//  NoteDetailViewModel.swift
//  NotesManager
//
//  Created by pnam on 06/08/2022.
//

import Foundation

protocol NoteDetailViewModel {
    var note: Note { get }
}

final class NoteDetailViewModelImpl: NoteDetailViewModel {
    var note: Note
    
    init(note: Note) {
        self.note = note
    }
}
