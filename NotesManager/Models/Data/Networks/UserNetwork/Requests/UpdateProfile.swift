//
//  UpdateProfile.swift
//  NotesManager
//
//  Created by pnam on 30/07/2022.
//

@_implementationOnly import Alamofire

struct UpdateProfileRequest: UserNetworkRequest {
    typealias Response = UpdateProfileResponse
    
    var method: HTTPMethod = .patch
    var path: String = "update-profile"
    var encoding: URLEncoding = .httpBody
    var parameters: Parameters
    
    var interceptor: RequestInterceptor? {
        NoteManagerAssembler.inject(name: .tokenInterceptor)
    }
    
    init(name: String? = nil, gender: String? = nil) {
        parameters = [:]
        if let name = name {
            parameters.updateValue(name, forKey: "name")
        }
        if let gender = gender {
            parameters.updateValue(gender, forKey: "gender")
        }
    }
}

struct UpdateProfileResponse {
    let id: String
    let email, name, gender: String
}

extension UpdateProfileResponse: Codable {
    private enum CodingKeys: String, CodingKey {
        case id = "_id"
        case email, name, gender
    }
}
