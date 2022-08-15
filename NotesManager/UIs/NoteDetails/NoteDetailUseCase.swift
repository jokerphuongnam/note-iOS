//
//  NoteDetailUseCase.swift
//  NotesManager
//
//  Created by pnam on 15/08/2022.
//

@_implementationOnly import RxSwift

protocol NoteDetailUseCase {
    func deleteNote(id: String) -> Completable
}

final class NoteDetailUseCaseImpl: NoteDetailUseCase {
    var noteRepository: NoteRepository!
    
    init(noteRepository: NoteRepository) {
        self.noteRepository = noteRepository
    }
    
    deinit {
        noteRepository = nil
    }
    
    func deleteNote(id: String) -> Completable {
        noteRepository.deleteNote(id: id)
            .subscribe(on: SerialDispatchQueueScheduler.init(qos: .utility))
            .observe(on: MainScheduler.instance)
    }
}
