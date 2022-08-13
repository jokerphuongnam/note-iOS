//
//  TokenInterceptor.swift
//  NotesManager
//
//  Created by pnam on 13/08/2022.
//

@_implementationOnly import Alamofire
@_implementationOnly import RxSwift
@_implementationOnly import JWTDecode

final class TokenInterceptor: RequestInterceptor {
    private var network: UserNetwork!
    private var local: UserLocal!
    private lazy var disposeBag: DisposeBag = DisposeBag()
    
    init(network: UserNetwork, local: UserLocal) {
        self.network = network
        self.local = local
    }
    
    deinit {
        network = nil
        local = nil
    }
    
    
    func adapt(_ urlRequest: URLRequest, using state: RequestAdapterState, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var urlRequest = urlRequest
        if let accessToken = local.accessToken {
            urlRequest.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
            completion(.success(urlRequest))
        } else {
            fetchAccessToken { [weak self] result in
                guard let self = self else {
                    completion(.failure(NError.ownerNil))
                    return
                }
                switch result {
                case .success(let accessToken):
                    self.local.accessToken = accessToken
                    urlRequest.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
                    completion(.success(urlRequest))
                case .failure(let error):
                    self.changeRootViewToLoginViewController()
                    completion(.failure(error))
                }
            }
        }
    }
    
    private func fetchAccessToken(completion: @escaping FetchAccessTokenCompletion) {
        let date = Date()
        let currentDate = date.millisecondsSince1970
        guard let token = try? local.loginToken(), let jwt = try? decode(jwt: token), let expiresAt = jwt.expiresAt?.millisecondsSince1970, currentDate + Int64(Int.networkTimeOut * 1000) < expiresAt else {
            return completion(.failure(.tokenExpired))
        }
        fetchAccessToken(accessToken: token, completion: completion)
    }
    
    private func fetchAccessToken(accessToken token: String, completion: @escaping FetchAccessTokenCompletion) {
        network.fetchAccessToken(loginToken: token)
            .subscribe { accessToken in
                completion(.success(accessToken))
            } onFailure: { error in
                completion(.failure(.tokenExpired))
            } onDisposed: {
                
            }
            .disposed(by: disposeBag)
    }
    
    private func changeRootViewToLoginViewController() {
        let viewModel: LoginViewModel = LoginViewModelImpl(useCase: NoteManagerAssembler.inject())
        let viewController = LoginViewController(viewModel: viewModel)
        let navigation = UINavigationController(rootViewController: viewController)
        UIWindow.key?.changeRootViewControllerPresent(rootViewController: navigation)
    }
}

private extension TokenInterceptor {
    enum TokenInterceptorError: Error {
        case tokenExpired
    }
    
    typealias FetchAccessTokenCompletion = (_ result: Result<String, TokenInterceptorError>) -> ()
}
