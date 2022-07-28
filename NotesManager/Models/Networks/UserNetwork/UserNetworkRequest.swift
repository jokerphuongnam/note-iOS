//
//  UserNetworkRequest.swift
//  NotesManager
//
//  Created by pnam on 28/07/2022.
//

@_implementationOnly import Alamofire

protocol UserNetworkRequest: Request {}

extension UserNetworkRequest {
    var baseURL: URL {
        URL(string: .baseUrl)!
    }
    
    var encoding: URLEncoding {
        .default
    }
    
    var httpHeaderFields: HTTPHeaders {
        [:]
    }
}
