//
//  Register.swift
//  NotesManager
//
//  Created by pnam on 29/07/2022.
//

@_implementationOnly import Alamofire

struct RegisterRequest: UserNetworkRequest {
    typealias Response = RegisterResponse
    
    var method: HTTPMethod = .post
    var path: String = "register"
    var encoding: URLEncoding = .httpBody
    var parameters: Parameters
    var interceptor: RequestInterceptor? { nil }
    
    init(email: String, password: String) {
        parameters = [
            "email": email,
            "password": password
        ]
    }
}

struct RegisterResponse {
    let id: String
    let email, name, gender: String
}

extension RegisterResponse: Codable {
    private enum CodingKeys: String, CodingKey {
        case id = "_id"
        case email, name, gender
    }
}
