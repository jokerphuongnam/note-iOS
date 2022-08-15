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
}

final class NoteDetailViewModelImpl: NoteDetailViewModel {
    var noteObserver: BehaviorRelay<Note>
    var note: Note {
        noteObserver.value
    }
    
    init(note: Note) {
        noteObserver = BehaviorRelay(value: note)
    }
}
