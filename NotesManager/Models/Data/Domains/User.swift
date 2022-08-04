//
//  User.swift
//  NotesManager
//
//  Created by pnam on 28/07/2022.
//

import Foundation

struct User {
    let id, email, password, name: String
    let gender: String
    let v: Int
    let token: String
}

typealias Users = [User]
