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
    var httpHeaderFields: HTTPHeaders = [
        "Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiNjJkZDIwMTZmMzQ0MjEyYTI0M2FhZjczIiwiZW1haWwiOiJwaHVvbmduYW1wOTlAZ21haWwuY29tIiwiaWF0IjoxNjU5MzQ1MzM5LCJleHAiOjE2NTkzNDcxMzl9.LhKIUDkQkG4PrskAQaEPuMGSfmGWS8m7JSP1LqheH0U"]
    
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
