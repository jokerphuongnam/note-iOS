//
//  Resource.swift
//  NotesManager
//
//  Created by pnam on 04/08/2022.
//

import Foundation

enum Resource<T> {
    case `init`
    case loading
    case success(data: T)
}
