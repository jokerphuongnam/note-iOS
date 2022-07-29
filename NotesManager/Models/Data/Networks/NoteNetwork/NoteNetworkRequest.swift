//
//  NoteNetworkRequest.swift
//  NotesManager
//
//  Created by pnam on 28/07/2022.
//

@_implementationOnly import Alamofire

protocol NoteNetworkRequest: Request {}

extension NoteNetworkRequest {
    var baseURL: URL {
        URL(string: "\(String.baseUrl)notes/")!
    }
    
    var encoding: URLEncoding {
        .default
    }
    
    var httpHeaderFields: HTTPHeaders {
        [:]
    }
}
