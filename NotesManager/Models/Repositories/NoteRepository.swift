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
    private var network: NoteNetwork!
    private var local: NoteLocal!
    
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
            .flatMap { [weak self] response in
                let pagingNotes = response.pagingNotes
                guard let self = self else { return Single.just(pagingNotes) }
                return self.local.clearNote()
                    .andThen(self.local.addNotes(notes: pagingNotes.data))
                    .catch { e in
                        Completable.empty()
                    }
                    .andThen(Single.just(pagingNotes))
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
            .flatMap { [weak self] response in
                let note = response.note
                guard let self = self else { return Single.just(note) }
                return self.local.updateNote(note: note)
                    .andThen(Single.just(note))
            }
    }
    
    func deleteNote(id: String) -> Completable {
        network.deleteNote(id: id)
            .flatMapCompletable { [weak self] response in
                guard let self = self else { return Completable.empty() }
                return self.local.deleteNote(id: response.id)
            }
    }
    
    func deleteTempNoteWhenInsert() {
        local.deleteTempNoteWhenInsert()
    }
}
