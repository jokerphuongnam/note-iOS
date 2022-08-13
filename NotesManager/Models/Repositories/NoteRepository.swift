//
//  NoteRepository.swift
//  NotesManager
//
//  Created by pnam on 13/08/2022.
//

@_implementationOnly import RxSwift

protocol NoteRepository {
    func getNotes(page: Int?, limit: Int?, searchWords: String?) -> Single<PagingArray<Note>>
}

final class NoteRepositoryImpl: NoteRepository {
    var network: NoteNetwork!
    
    init(network: NoteNetwork) {
        self.network = network
    }
    
    deinit {
        network = nil
    }
    
    func getNotes(page: Int?, limit: Int?, searchWords: String?) -> Single<PagingArray<Note>> {
        network.fetchNotes(page: page, limit: limit, searchWords: searchWords)
            .map { response in
                response.paingNotes
            }
    }
}
