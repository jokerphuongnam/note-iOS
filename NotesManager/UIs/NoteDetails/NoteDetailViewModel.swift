//
//  NoteDetailViewModel.swift
//  NotesManager
//
//  Created by pnam on 06/08/2022.
//

@_implementationOnly import RxSwift
@_implementationOnly import RxCocoa
@_implementationOnly import RxRelay

protocol NoteDetailViewModel {
    var noteObserver: BehaviorRelay<Note> { get }
    var note: Note { get }
    func deleteNote() -> Completable
}

final class NoteDetailViewModelImpl: NoteDetailViewModel {
    var useCase: NoteDetailUseCase!
    var noteObserver: BehaviorRelay<Note>
    var note: Note {
        noteObserver.value
    }
    
    init(useCase: NoteDetailUseCase, note: Note) {
        self.useCase = useCase
        noteObserver = BehaviorRelay(value: note)
        
    }
    
    deinit {
        useCase = nil
    }
    
    func deleteNote() -> Completable {
        useCase.deleteNote(id: note.id)
    }
}
