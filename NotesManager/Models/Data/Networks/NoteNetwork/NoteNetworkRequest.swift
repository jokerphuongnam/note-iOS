//
//  NoteNetworkRequest.swift
//  NotesManager
//
//  Created by pnam on 28/07/2022.
//

@_implementationOnly import Alamofire

// MARK: - UserNetworkRequest
protocol NoteNetworkRequest: Request {}

// MARK: - Default UserNetworkRequest
extension NoteNetworkRequest {
    var baseURL: URL {
        URL(string: .baseUrl)!
    }
    
    var encoding: URLEncoding {
        .default
    }
    
    var httpHeaderFields: HTTPHeaders {
        [:]
    }
    
    var parameters: Parameters {
        [:]
    }
    
    var interceptor: Interceptor? {
        nil
    }
    
    var url: URL {
        baseURL.appendingPathComponent(path)
    }
}
