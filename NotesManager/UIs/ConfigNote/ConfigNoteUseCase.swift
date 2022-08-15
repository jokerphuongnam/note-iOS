//
//  ConfigNoteUseCase.swift
//  NotesManager
//
//  Created by pnam on 14/08/2022.
//

@_implementationOnly import RxSwift

protocol ConfigNoteUseCase {
    func addNote(note: Note) -> Single<Note>
    func updateNote(note: Note) -> Single<Note>
}

final class ConfigNoteUseCaseImpl: ConfigNoteUseCase {
    var noteRepository: NoteRepository!
    
    init(noteRepository: NoteRepository) {
        self.noteRepository = noteRepository
    }
    
    deinit {
        noteRepository = nil
    }
    
    func addNote(note: Note) -> Single<Note> {
        noteRepository.addNote(note: note)
            .subscribe(on: SerialDispatchQueueScheduler.init(qos: .utility))
            .observe(on: MainScheduler.instance)
    }
    
    func updateNote(note: Note) -> Single<Note> {
        noteRepository.updateNote(note: note)
            .subscribe(on: SerialDispatchQueueScheduler.init(qos: .utility))
            .observe(on: MainScheduler.instance)
    }
}
