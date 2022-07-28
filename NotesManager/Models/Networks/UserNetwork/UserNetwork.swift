//
//  UserNetwork.swift
//  NotesManager
//
//  Created by pnam on 28/07/2022.
//

@_implementationOnly import RxSwift
@_implementationOnly import Alamofire

protocol UserNetwork {
    func login(email: String, password: String) -> Single<LoginRequest.Response>
}

final class AFUserNetwork: UserNetwork, BaseAFNetwork {
    var session: Session
    
    init(session: Session) {
        self.session = session
    }
    
    func login(email: String, password: String) -> Single<LoginResponse> {
        rx.send(request: LoginRequest(email: email, password: password))
    }
}
