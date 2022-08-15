//
//  ConfigNoteViewModel.swift
//  NotesManager
//
//  Created by pnam on 06/08/2022.
//

@_implementationOnly import UIKit
@_implementationOnly import RxSwift

protocol ConfigNoteViewModel {
    var action: NoteAction { get }
    var note: Note { get set }
    var tempNoteWhenInsert: Note? { get set }
    func confirmAction() -> Single<Note>
    func deleteTempNoteWhenInsert()
}

final class ConfigNoteViewModelImpl: ConfigNoteViewModel {
    private var useCase: ConfigNoteUseCase!
    
    var action: NoteAction
    var note: Note {
        willSet {
            if action == .add {
                var note = Note(id: "", color: newValue.color, createAt: 0, updateAt: 0)
                if let title = newValue.title, !title.isEmpty {
                    note.title = title
                } else {
                    note.title = nil
                }
                if let description = newValue.description, !description.isEmpty {
                    note.description = description
                } else {
                    note.description = nil
                }
                useCase.tempNoteWhenInsert = note
            }
        }
    }
    
    var tempNoteWhenInsert: Note? {
        get {
            useCase.tempNoteWhenInsert
        }
        set {
            useCase.tempNoteWhenInsert = newValue
        }
    }
    
    init(useCase: ConfigNoteUseCase, note: Note? = nil) {
        self.useCase = useCase
        if let note = note {
            self.note = note
            self.action = .edit
        } else {
            self.note = useCase.tempNoteWhenInsert ?? .init(id: "", title: "", description: "", color: .init(hex: "#FBF048"), createAt: 0, updateAt: 0)
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
    
    func deleteTempNoteWhenInsert() {
        useCase.deleteTempNoteWhenInsert()
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
