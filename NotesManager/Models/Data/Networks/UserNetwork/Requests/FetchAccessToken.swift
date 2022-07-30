//
//  FetchAccessToken.swift
//  NotesManager
//
//  Created by pnam on 29/07/2022.
//

@_implementationOnly import Alamofire

struct FetchAccessTokenRequest: UserNetworkRequest {
    typealias Response = FetchAccessTokenResponse
    
    var method: HTTPMethod = .get
    var path: String = "get-access-token"
    var httpHeaderFields: HTTPHeaders
    
    init(loginToken: String) {
        httpHeaderFields = [
            "Authorization": "Bearer \(loginToken)"
        ]
    }
}

typealias FetchAccessTokenResponse = String
