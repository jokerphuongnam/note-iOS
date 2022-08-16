//
//  RealmManager.swift
//  NotesManager
//
//  Created by pnam on 16/08/2022.
//

@_implementationOnly import RxSwift
@_implementationOnly import Realm
@_implementationOnly import RealmS
@_implementationOnly import RealmSwift

protocol RealmManager {
    func findNotes() -> Single<Notes>
    func addNotes(notes: [Note]) -> Completable
    func updateNote(note: Note) -> Completable
    func deleteNote(id: String) -> Completable
    func clearNote() -> Completable
}

final class RealmManagerImpl: RealmManager {
    func findNotes() -> Single<Notes> {
        .create { [weak self] observer in
            guard self != nil else {
                observer(.failure(NError.ownerNil))
                return Disposables.create()
            }
            do {
                let realm = try Realm()
                let realmNotes = realm.objects(RealmNote.self)
                if realmNotes.first != nil {
                    let notes = Array(realmNotes).map { realmNote in
                        realmNote.note
                    }
                    observer(.success(notes))
                } else {
                    observer(.success([]))
                }
            } catch {
                observer(.failure(error))
            }
            return Disposables.create()
        }
    }
    
    func addNotes(notes: [Note]) -> Completable {
        .create { [weak self] observer in
            guard let self = self else {
                observer(.error(NError.ownerNil))
                return Disposables.create()
            }
            do {
                let realm = try Realm()
                try realm.write { [weak self] in
                    guard self != nil else {
                        observer(.error(NError.ownerNil))
                        return
                    }
                    notes.forEach { note in
                        realm.add(RealmNote(note: note))
                    }
                }
            } catch {
                observer(.error(error))
            }
            return Disposables.create()
        }
    }
    
    func updateNote(note: Note) -> Completable {
        .create { [weak self] observer in
            guard let self = self else {
                observer(.error(NError.ownerNil))
                return Disposables.create()
            }
            do {
                let realm = try Realm()
                let realmNotes = realm.objects(RealmNote.self).filter("id = %@", note.id)
                if let realmNote = realmNotes.first {
                    try realm.write { [weak self] in
                        guard self != nil else {
                            observer(.error(NError.ownerNil))
                            return
                        }
                        realmNote.update(note: note)
                    }
                } else {
                    observer(.error(RealmError.notFound))
                }
            } catch {
                observer(.error(error))
            }
            return Disposables.create()
        }
    }
    
    func deleteNote(id: String) -> Completable {
        .create { [weak self] observer in
            guard let self = self else {
                observer(.error(NError.ownerNil))
                return Disposables.create()
            }
            do {
                let realm = try Realm()
                let realmNotes = realm.objects(RealmNote.self).filter("id = %@", id)
                if realmNotes.first != nil {
                    try realm.write { [weak self] in
                        guard self != nil else {
                            observer(.error(NError.ownerNil))
                            return
                        }
                        realm.delete(realmNotes)
                    }
                } else {
                    observer(.error(RealmError.notFound))
                }
            } catch {
                observer(.error(error))
            }
            return Disposables.create()
        }
    }
    
    func clearNote() -> Completable {
        .create { [weak self] observer in
            guard let self = self else {
                observer(.error(NError.ownerNil))
                return Disposables.create()
            }
            do {
                let realm = try Realm()
                let realmNotes = realm.objects(RealmNote.self)
                if realmNotes.first != nil {
                    try realm.write { [weak self] in
                        guard self != nil else {
                            observer(.error(NError.ownerNil))
                            return
                        }
                        realm.delete(realmNotes)
                    }
                } else {
                    observer(.error(RealmError.notFound))
                }
            } catch {
                observer(.error(error))
            }
            return Disposables.create()
        }
    }
}

extension RealmManagerImpl {
    enum RealmError: Error {
        case notFound
    }
}
