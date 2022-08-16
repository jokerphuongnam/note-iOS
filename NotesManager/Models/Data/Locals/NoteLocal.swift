//
//  NoteLocal.swift
//  NotesManager
//
//  Created by pnam on 15/08/2022.
//

@_implementationOnly import RxSwift

protocol NoteLocal {
    var tempNoteWhenInsert: Note? { get set }
    func deleteTempNoteWhenInsert()
    func findNotes() -> Single<Notes>
    func addNotes(notes: [Note]) -> Completable
    func updateNote(note: Note) -> Completable
    func deleteNote(id: String) -> Completable
    func clearNote() -> Completable
}

final class NoteLocalImpl: NoteLocal {
    private var userDefaultsManager: UserDefaultsManager!
    private var realmManager: RealmManager!
    
    var tempNoteWhenInsert: Note? {
        get {
            userDefaultsManager.tempNoteWhenInsert
        }
        set {
            userDefaultsManager.tempNoteWhenInsert = newValue
        }
    }
    
    init(userDefaultsManager: UserDefaultsManager, realmManager: RealmManager) {
        self.userDefaultsManager = userDefaultsManager
        self.realmManager = realmManager
    }
    
    deinit {
        userDefaultsManager = nil
        realmManager = nil
    }
    
    func deleteTempNoteWhenInsert() {
        userDefaultsManager.deleteTempNoteWhenInsert()
    }
    
    func findNotes() -> Single<Notes> {
        realmManager.findNotes()
    }
    
    func addNotes(notes: [Note]) -> Completable {
        realmManager.addNotes(notes: notes)
    }
    
    func updateNote(note: Note) -> Completable {
        realmManager.updateNote(note: note)
    }
    
    func deleteNote(id: String) -> Completable {
        realmManager.deleteNote(id: id)
    }
    
    func clearNote() -> Completable {
        realmManager.clearNote()
    }
}
