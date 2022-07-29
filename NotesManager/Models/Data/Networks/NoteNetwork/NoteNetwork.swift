//
//  NoteNetwork.swift
//  NotesManager
//
//  Created by pnam on 28/07/2022.
//

@_implementationOnly import RxSwift
@_implementationOnly import Alamofire

protocol NoteNetwork {
    
}

final class AFNoteNetwork: NoteNetwork, BaseAFNetwork {
    var session: Session
    
    init(session: Session) {
        self.session = session
    }
}
