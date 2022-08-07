//
//  User.swift
//  NotesManager
//
//  Created by pnam on 28/07/2022.
//

import Foundation

struct User {
    let id: String
    var email: String
    var name: String, gender: Gender
}

extension User {
    enum Gender {
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
}

typealias Users = [User]
typealias Gender = User.Gender
