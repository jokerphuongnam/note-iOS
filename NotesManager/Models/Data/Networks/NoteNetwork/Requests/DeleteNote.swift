//
//  DeleteNote.swift
//  NotesManager
//
//  Created by pnam on 01/08/2022.
//

@_implementationOnly import Alamofire

struct DeleteNoteRequest: NoteNetworkRequest {
    typealias Response = DeleteNoteResponse
    
    var url: URL
    var method: HTTPMethod = .delete
    var path: String = "notes/delete-note"
    
    private init() {
        url = URL(string: .baseUrl)!
    }
    
    init(id: String) {
        self.init()
        url = self.baseURL.appendingPathComponent(path).appendingPathComponent("/\(id)")
    }
}

typealias DeleteNoteResponse = NoteResponse
