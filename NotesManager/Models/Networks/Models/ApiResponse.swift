//
//  ApiResponse.swift
//  NotesManager
//
//  Created by pnam on 28/07/2022.
//

@frozen public struct ApiResponse<Data: Decodable>: Decodable {
    var status: Bool
    var message: String
    var data: Data!
}

private extension ApiResponse {
    private enum CodingKeys: String, CodingKey {
        case status = "status"
        case message = "message"
        case data = "data"
    }
}
