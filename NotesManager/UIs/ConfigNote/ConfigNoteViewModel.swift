//
//  ConfigNoteViewModel.swift
//  NotesManager
//
//  Created by pnam on 06/08/2022.
//

@_implementationOnly import UIKit
@_implementationOnly import RxSwift

protocol ConfigNoteViewModel {
    var note: Note { get set }
    var action: NoteAction { get }
    func confirmAction() -> Single<Note>
}

final class ConfigNoteViewModelImpl: ConfigNoteViewModel {
    private var useCase: ConfigNoteUseCase!
    
    var note: Note
    var action: NoteAction
    
    init(useCase: ConfigNoteUseCase, note: Note? = nil) {
        self.useCase = useCase
        if let note = note {
            self.note = note
            self.action = .edit
        } else {
            self.note = .init(id: "", title: "", description: "", color: .init(hex: "#FBF048"), createAt: 0, updateAt: 0)
            self.action = .add
        }
    }
    
    deinit {
        useCase = nil
    }
    
    func confirmAction() -> Single<Note> {
        switch action {
        case .add:
            return useCase.addNote(note: note)
        case .edit:
            return useCase.updateNote(note: note)
        }
    }
}

extension ConfigNoteViewModelImpl {
    enum NoteAction {
        case add
        case edit
    }
}

extension NoteAction {
    var title: String {
        switch self {
        case .add:
            return Strings.addNote
        case .edit:
            return Strings.editNote
        }
    }
}

typealias NoteAction = ConfigNoteViewModelImpl.NoteAction
