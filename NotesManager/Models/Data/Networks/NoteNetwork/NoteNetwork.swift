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
    // MARK: - fetch notes
    func fetchNotes(page: Int?, limit: Int?, searchWords: String?) -> Single<FetchNotesRequest.Response>
    // MARK: - insert note
    func inserNote(title: String?, description: String?, color: String?) -> Single<InsertNoteRequest.Response>
    // MARK: - update note
    func updateNote(id: String, title: String?, description: String?, color: String?) -> Single<UpdateNoteRequest.Response>
    // MARK: - delete note
    func deleteNote(id: String) -> Single<DeleteNoteRequest.Response>
}

// MARK: - AFNoteNetwork
final class AFNoteNetwork: NoteNetwork, BaseAFNetwork {
    var session: Session!
    var decoder: JSONDecoder!
    
    // MARK: - Init
    init(session: Session, decoder: JSONDecoder) {
        self.session = session
        self.decoder = decoder
    }
    
    deinit {
        session = nil
        decoder = nil
    }
    
    // MARK: - fetch notes
    func fetchNotes(page: Int?, limit: Int?, searchWords: String?) -> Single<FetchNotesRequest.Response> {
        rx.send(request: FetchNotesRequest(page: page, limit: limit, searchWords: searchWords))
    }
    
    // MARK: - insert note
    func inserNote(title: String?, description: String?, color: String?) -> Single<InsertNoteRequest.Response> {
        rx.send(request: InsertNoteRequest(title: title, description: description, color: color))
    }
    
    // MARK: - update note
    func updateNote(id: String, title: String?, description: String?, color: String?) -> Single<UpdateNoteRequest.Response> {
        rx.send(request: UpdateNoteRequest(id: id, title: title, description: description, color: color))
    }
    
    // MARK: - delete note
    func deleteNote(id: String) -> Single<DeleteNoteRequest.Response> {
        rx.send(request: DeleteNoteRequest(id: id))
    }
}
