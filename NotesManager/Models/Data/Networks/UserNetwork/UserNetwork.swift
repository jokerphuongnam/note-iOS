//
//  UserNetwork.swift
//  NotesManager
//
//  Created by pnam on 28/07/2022.
//

@_implementationOnly import RxSwift
@_implementationOnly import Alamofire

// MARK: - UserNetwork
protocol UserNetwork {
    // MARK: - login
    func login(email: String, password: String) -> Single<LoginRequest.Response>
    // MARK: - register
    func register(email: String, password: String) -> Single<RegisterRequest.Response>
}

// MARK: - AFUserNetwork
final class AFUserNetwork: UserNetwork, BaseAFNetwork {
    var session: Session
    
    // MARK: - Init
    init(session: Session) {
        self.session = session
    }
    
    // MARK: - login
    func login(email: String, password: String) -> Single<LoginResponse> {
        rx.send(request: LoginRequest(email: email, password: password))
    }
    
    // MARK: - register
    func register(email: String, password: String) -> Single<RegisterResponse> {
        rx.send(request: RegisterRequest(email: email, password: password))
    }
}
