//
//  UserNetwork.swift
//  NotesManager
//
//  Created by pnam on 28/07/2022.
//

@_implementationOnly import RxSwift
@_implementationOnly import Alamofire

protocol UserNetwork {
    
}

final class AFUserNetwork: UserNetwork, BaseAFNetwork {
    var session: Session
    
    init(session: Session) {
        self.session = session
    }
}
