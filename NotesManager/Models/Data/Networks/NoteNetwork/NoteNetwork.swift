//
//  NoteNetwork.swift
//  NotesManager
//
//  Created by pnam on 28/07/2022.
//

@_implementationOnly import RxSwift
@_implementationOnly import Alamofire

// MARK: - NoteNetwork
protocol NoteNetwork {
    //MARK: - fetch notes
    func fetchNotes(page: Int?, limit: Int?, searchWords: String?) -> Single<FetchNotesRequest.Response>
}

// MARK: - AFNoteNetwork
final class AFNoteNetwork: NoteNetwork, BaseAFNetwork {
    var session: Session
    
    // MARK: - Init
    init(session: Session) {
        self.session = session
    }
    
    //MARK: - fetch notes
    func fetchNotes(page: Int?, limit: Int?, searchWords: String?) -> Single<FetchNotesRequest.Response> {
        rx.send(request: FetchNotesRequest(page: page, limit: limit, searchWords: searchWords))
    }
}
