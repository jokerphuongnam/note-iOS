//
//  Note.swift
//  NotesManager
//
//  Created by pnam on 04/08/2022.
//

import Foundation
@_implementationOnly import UIKit

struct Note {
    let id: String
    var title: String?
    var description: String?
    var color: UIColor
    let createAt, updateAt: Int64
}

typealias Notes = [Note]
