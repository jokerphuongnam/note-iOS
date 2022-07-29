//
//  ApiResponse.swift
//  NotesManager
//
//  Created by pnam on 28/07/2022.
//

@frozen public struct ApiResponse<T> where T: Codable {
    let statusCode: Int
    let status: Bool
    let message: String
    let data: T!
}

extension ApiResponse: Codable {
    private enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case status, message, data
    }
}
