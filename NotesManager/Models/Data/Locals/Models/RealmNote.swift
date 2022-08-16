//
//  RealmNote.swift
//  NotesManager
//
//  Created by pnam on 16/08/2022.
//

@_implementationOnly import Realm
@_implementationOnly import RealmS
@_implementationOnly import RealmSwift

final class RealmNote: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var title: String? = nil
    @objc dynamic var noteDescription: String? = nil
    @objc dynamic var color: String = ""
    @objc dynamic var createAt: Int64 = 0
    @objc dynamic var updateAt: Int64 = 0
    
    override class func primaryKey() -> String? {
        "id"
    }
}

extension RealmNote {
    convenience init(note: Note) {
        self.init()
        self.id = note.id
        self.title = note.title
        self.noteDescription = note.description
        self.color = note.color.stringHex
        self.createAt = note.createAt
        self.updateAt = note.updateAt
    }
    
    @discardableResult
    func update(note: Note) -> Self {
        title = note.title
        noteDescription = note.description
        color = note.color.stringHex
        createAt = note.createAt
        updateAt = note.updateAt
        return self
    }
    
    var note: Note {
        .init(id: id, title: title, description: noteDescription, color: .init(hex: color), createAt: createAt, updateAt: updateAt)
    }
}
