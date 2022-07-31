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
    // MARK: - fetch access token
    func fetchAccessToken(loginToken: String) -> Single<FetchAccessTokenRequest.Response>
    // MARK: - update profile
    func updateProfile(name: String?, gender: String?) -> Single<UpdateProfileRequest.Response>
}

// MARK: - AFUserNetwork
final class AFUserNetwork: UserNetwork, BaseAFNetwork {
    var session: Session
    
    // MARK: - Init
    init(session: Session) {
        self.session = session
    }
    
    // MARK: - login
    func login(email: String, password: String) -> Single<LoginRequest.Response> {
        rx.send(request: LoginRequest(email: email, password: password))
    }
    
    // MARK: - register
    func register(email: String, password: String) -> Single<RegisterRequest.Response> {
        rx.send(request: RegisterRequest(email: email, password: password))
    }
    
    // MARK: - fetch access token
    func fetchAccessToken(loginToken: String) -> Single<FetchAccessTokenRequest.Response> {
        rx.send(request: FetchAccessTokenRequest(loginToken: loginToken))
    }
    
    // MARK: - update profile
    func updateProfile(name: String?, gender: String?) -> Single<UpdateProfileRequest.Response> {
        rx.send(request: UpdateProfileRequest(name: name, gender: gender))
    }
}
