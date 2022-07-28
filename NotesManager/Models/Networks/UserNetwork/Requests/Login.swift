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

struct LoginResponse: Decodable {
    let id, email, password, name: String
        let gender: String
        let v: Int
        let token: String
}

private extension LoginResponse {
    private enum CodingKeys: String, CodingKey {
    case id = "_id"
    case email, password, name, gender
    case v = "__v"
    case token
}
}
