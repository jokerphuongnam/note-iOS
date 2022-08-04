//
//  Note.swift
//  NotesManager
//
//  Created by pnam on 04/08/2022.
//

import Foundation

struct Note {
    let id: String
    let title: String?
    let description: String?
    let color: String
    let createAt, updateAt: Int64
}

typealias Notes = [Note]
