//
//  ApiError.swift
//  NotesManager
//
//  Created by pnam on 28/07/2022.
//

import Foundation

struct ResponseError: Decodable {
    let status: Bool?
    let message: String?

    init(_ status: Bool) {
        self.status = status
        message = nil
    }

    init(_ message: String) {
        status = nil
        self.message = message
    }
    
    init(status: Bool, message: String) {
        self.status = status
        self.message = message
    }
}

extension ResponseError: Equatable {
    static func == (lhs: ResponseError, rhs: ResponseError) -> Bool {
        return lhs.status == rhs.status && lhs.message == rhs.message
    }
}

enum ApiError: Error {
    case connectionFailed(Error)
    case serverError
    case maintenance
    case otherError(ResponseError)
    case unknownError(ResponseError)
    case dataNotExist
    case statusCodeNotExist
    case timeout
    case noConnection
    case expired

    func responseDecode() -> Decodable? {
        switch self {
        case .connectionFailed(_):
            return nil
        case .serverError:
            return nil
        case .maintenance:
            return nil
        case .otherError(let data):
            return data
        case .unknownError(let data):
            return data
        case .dataNotExist:
            return nil
        case .statusCodeNotExist:
            return nil
        case .timeout:
            return nil
        case .noConnection:
            return nil
        case .expired:
            return nil
        }
    }
}

extension ApiError: Equatable {
    static func == (lhs: ApiError, rhs: ApiError) -> Bool {
        switch (lhs, rhs) {
        case (.connectionFailed(_), .connectionFailed(_)):
            return true
        case (.serverError, .serverError):
            return true
        case (.maintenance, .maintenance):
            return true
        case (.otherError(let a), .otherError(let b)):
            return a == b
        case (.unknownError(let a), .unknownError(let b)):
            return a == b
        case (.dataNotExist, .dataNotExist):
            return true
        case (.statusCodeNotExist, .statusCodeNotExist):
            return true
        default:
            return false
        }
    }
}
