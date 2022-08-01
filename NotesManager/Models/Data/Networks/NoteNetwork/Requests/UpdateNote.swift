//
//  UpdateNote.swift
//  NotesManager
//
//  Created by pnam on 01/08/2022.
//

@_implementationOnly import Alamofire

struct UpdateNoteRequest: NoteNetworkRequest {
    typealias Response = InsertNoteResponse
    
    var method: HTTPMethod = .patch
    var path: String = "notes/update-note"
    var encoding: URLEncoding = .httpBody
    var parameters: Parameters
    
    init(id: String, title: String?, description: String?) {
        parameters = [
            "id": id
        ]
        
        if let title = title {
            parameters.updateValue(title, forKey: "title")
        }
        
        if let description = description {
            parameters.updateValue(description, forKey: "description")
        }
    }
}

typealias UpdateNoteResponse = NoteResponse
