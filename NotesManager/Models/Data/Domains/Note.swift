//
//  Note.swift
//  NotesManager
//
//  Created by pnam on 04/08/2022.
//

@_implementationOnly import UIKit

struct Note {
    let id: String
    var title, description: String?
    var color: UIColor
    let createAt, updateAt: Int64
}

struct CodableNote: Codable {
    let id: String
    let title, description: String?
    let color: String
    
    init(note: Note) {
        id = note.id
        title = note.title
        description = note.description
        color = note.color.stringHex
    }
    
    var note: Note {
        .init(id: id, title: title, description: description, color: .init(hex: color), createAt: 0, updateAt: 0)
    }
}

typealias Notes = [Note]
