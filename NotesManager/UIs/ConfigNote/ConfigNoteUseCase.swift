//
//  ConfigNoteUseCase.swift
//  NotesManager
//
//  Created by pnam on 14/08/2022.
//

@_implementationOnly import RxSwift

protocol ConfigNoteUseCase {
    var tempNoteWhenInsert: Note? { get set }
    func addNote(note: Note) -> Single<Note>
    func updateNote(note: Note) -> Single<Note>
    func deleteTempNoteWhenInsert()
}

final class ConfigNoteUseCaseImpl: ConfigNoteUseCase {
    var noteRepository: NoteRepository!
    
    var tempNoteWhenInsert: Note? {
        get {
            noteRepository.tempNoteWhenInsert
        }
        set {
            noteRepository.tempNoteWhenInsert = newValue
        }
    }
    
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
    
    func deleteTempNoteWhenInsert() {
        noteRepository.deleteTempNoteWhenInsert()
    }
}
