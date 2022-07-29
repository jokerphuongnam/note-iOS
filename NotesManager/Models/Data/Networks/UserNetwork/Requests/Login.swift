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
    var url: URL { baseURL.appendingPathComponent(path) }
    var parameters: Parameters
    
    init(email: String, password: String) {
        parameters = [
            "email": email,
            "password": password
        ]
    }
}

struct LoginResponse {
    let id, email, password, name: String
    let gender: String
    let token: String
}

extension LoginResponse: Codable {
    private enum CodingKeys: String, CodingKey {
        case id = "_id"
        case email, password, name, gender
        case token
    }
}
