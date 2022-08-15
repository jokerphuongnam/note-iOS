//
//  NoteRepository.swift
//  NotesManager
//
//  Created by pnam on 13/08/2022.
//

@_implementationOnly import RxSwift

protocol NoteRepository {
    var tempNoteWhenInsert: Note? { get set }
    func getNotes(page: Int?, limit: Int?, searchWords: String?) -> Single<PagingArray<Note>>
    func addNote(note: Note) -> Single<Note>
    func updateNote(note: Note) -> Single<Note>
    func deleteNote(id: String) -> Completable
    func deleteTempNoteWhenInsert()
}

final class NoteRepositoryImpl: NoteRepository {
    var network: NoteNetwork!
    var local: NoteLocal!
    
    var tempNoteWhenInsert: Note? {
        get {
            local.tempNoteWhenInsert
        }
        set {
            local.tempNoteWhenInsert = newValue
        }
    }
    
    init(network: NoteNetwork, local: NoteLocal) {
        self.network = network
        self.local = local
    }
    
    deinit {
        network = nil
        local = nil
    }
    
    func getNotes(page: Int?, limit: Int?, searchWords: String?) -> Single<PagingArray<Note>> {
        network.fetchNotes(page: page, limit: limit, searchWords: searchWords)
            .map { response in
                response.paingNotes
            }
    }
    
    func addNote(note: Note) -> Single<Note> {
        network.inserNote(title: note.title, description: note.description, color: note.color.stringHex)
            .map { response in
                response.note
            }
    }
    
    func updateNote(note: Note) -> Single<Note> {
        network.updateNote(id: note.id ,title: note.title, description: note.description, color: note.color.stringHex)
            .map { response in
                response.note
            }
    }
    
    func deleteNote(id: String) -> Completable {
        network.deleteNote(id: id)
            .asCompletable()
    }
    
    func deleteTempNoteWhenInsert() {
        local.deleteTempNoteWhenInsert()
    }
}
