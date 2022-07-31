//
//  ChangePassword.swift
//  NotesManager
//
//  Created by pnam on 31/07/2022.
//

@_implementationOnly import Alamofire

struct ChangePasswordRequest: UserNetworkRequest {
    typealias Response = ChangePasswordResponse
    
    var method: HTTPMethod = .patch
    var path: String = "change-password"
    var encoding: URLEncoding = .httpBody
    var parameters: Parameters
    
    init(oldPassword: String, newPassword: String) {
        parameters = [
            "old_password":oldPassword,
            "new_password": newPassword
        ]
    }
}

struct ChangePasswordResponse {
    let id: String
    let email, name, gender: String
}

extension ChangePasswordResponse: Codable {
    private enum CodingKeys: String, CodingKey {
        case id = "_id"
        case email, name, gender
    }
}
