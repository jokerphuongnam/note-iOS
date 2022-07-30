//
//  Login.swift
//  NotesManager
//
//  Created by pnam on 28/07/2022.
//

@_implementationOnly import Alamofire

struct LoginRequest: UserNetworkRequest {
    typealias Response = LoginResponse
    
    var method: HTTPMethod = .post
    var path: String = "login"
    var encoding: URLEncoding { .httpBody }
    var parameters: Parameters
    
    init(email: String, password: String) {
        parameters = [
            "email": email,
            "password": password
        ]
    }
}

struct LoginResponse {
    let id, email, name: String
    let gender: String
    let token: String
}

extension LoginResponse: Codable {
    private enum CodingKeys: String, CodingKey {
        case id = "_id"
        case email, name, gender
        case token
    }
}
