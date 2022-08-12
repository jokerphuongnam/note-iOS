//
//  User.swift
//  NotesManager
//
//  Created by pnam on 28/07/2022.
//

import Foundation

struct User: Codable {
    let id: String
    var email: String
    var name: String, gender: Gender
}

extension User {
    enum Gender: Codable {
        case male
        case female
        case other
        case secret
    }
}

extension User.Gender: CaseIterable {
    
}

extension User.Gender {
    var text: String {
        switch self {
        case .male:
            return Strings.male
        case .female:
            return Strings.female
        case .other:
            return Strings.other
        case .secret:
            return Strings.secret
        }
    }
    
    var constant: String {
        switch self {
        case .male:
            return "male"
        case .female:
            return "female"
        case .other:
            return "other"
        case .secret:
            return "secret"
        }
    }
    
    init(gender text: String) {
        switch text.lowercased() {
        case "male":
            self = .male
        case "female":
            self = .female
        case "other":
            self = .other
        case "secret":
            self = .secret
        default:
            self = .secret
        }
    }
}

typealias Users = [User]
typealias Gender = User.Gender
