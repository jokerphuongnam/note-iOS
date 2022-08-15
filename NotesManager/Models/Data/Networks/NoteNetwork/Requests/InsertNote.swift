//
//  InsertNote.swift
//  NotesManager
//
//  Created by pnam on 01/08/2022.
//

@_implementationOnly import Alamofire

struct InsertNoteRequest: NoteNetworkRequest {
    typealias Response = InsertNoteResponse
    
    var method: HTTPMethod = .post
    var path: String = "notes/insert-note"
    var encoding: URLEncoding = .httpBody
    var parameters: Parameters
    
    init(title: String?, description: String?, color: String?) {
        parameters = [:]
        
        if let title = title {
            parameters.updateValue(title, forKey: "title")
        }
        
        if let description = description {
            parameters.updateValue(description, forKey: "description")
        }
        
        if let color = color {
            parameters.updateValue(color, forKey: "color")
        }
    }
}

typealias InsertNoteResponse = NoteResponse
