//
//  FetchNotes.swift
//  NotesManager
//
//  Created by pnam on 01/08/2022.
//

@_implementationOnly import Alamofire

struct FetchNotesRequest: NoteNetworkRequest {
    typealias Response = FetchNotesResponse
    
    var method: HTTPMethod = .get
    var path: String = "notes"
    var encoding: URLEncoding = .queryString
    var parameters: Parameters
    
    init(page: Int?, limit: Int?, searchWords: String?) {
        parameters = [:]
        if let page = page {
            parameters.updateValue(page, forKey: "page")
        }
        if let limit = limit {
            parameters.updateValue(limit, forKey: "limit")
        }
        if let searchWords = searchWords {
            parameters.updateValue(searchWords, forKey: "search_words")
        }
    }
}

struct FetchNotesResponse {
    let notes: NotesResponse
    let hasPrePage, hasNextPage: Bool
}

extension FetchNotesResponse {
    var paingNotes: PagingArray<Note> {
        (
            data: notes.map { noteResponse in
                noteResponse.note
            },
            hasNext: hasNextPage,
            hasPrev: hasPrePage
        )
    }
}

extension FetchNotesResponse: Codable {
    private enum CodingKeys: String, CodingKey {
        case notes
        case hasPrePage = "has_pre_page"
        case hasNextPage = "has_next_page"
    }
}

struct NoteResponse {
    let id: String
    let title, description: String?
    let color: String
    let createAt, updateAt: Int64
}

typealias NotesResponse = [NoteResponse]

extension NoteResponse: Codable {
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case title
        case description = "description"
        case color
        case createAt = "create_at"
        case updateAt = "update_at"
    }
}

extension NoteResponse {
    var note: Note {
        .init(id: id, title: title, description: description, color: .init(hex: color), createAt: createAt, updateAt: updateAt)
    }
}
