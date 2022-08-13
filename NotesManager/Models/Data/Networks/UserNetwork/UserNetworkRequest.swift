//
//  UserNetworkRequest.swift
//  NotesManager
//
//  Created by pnam on 28/07/2022.
//

@_implementationOnly import Alamofire

// MARK: - UserNetworkRequest
protocol UserNetworkRequest: Request {}

// MARK: - Default UserNetworkRequest
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
    
    var parameters: Parameters {
        [:]
    }
    
    var interceptor: RequestInterceptor? {
        nil
    }
    
    var url: URL {
        baseURL.appendingPathComponent(path)
    }
}
