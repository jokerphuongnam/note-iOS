//
//  DashboardUseCase.swift
//  NotesManager
//
//  Created by pnam on 13/08/2022.
//

@_implementationOnly import RxSwift

protocol DashboardUseCase {
    func getNotes(page: Int?, searchWords: String?) -> Single<PagingArray<Note>>
}

final class DashboardUseCaseImpl: DashboardUseCase {
    private var noteRepository: NoteRepository!
    
    init(noteRepository: NoteRepository) {
        self.noteRepository = noteRepository
    }
    
    deinit {
        noteRepository = nil
    }
    
    func getNotes(page: Int?, searchWords: String?) -> Single<PagingArray<Note>> {
        noteRepository.getNotes(page: page, limit: 10, searchWords: searchWords)
            .subscribe(on: SerialDispatchQueueScheduler.init(qos: .utility))
            .observe(on: MainScheduler.instance)
    }
}
