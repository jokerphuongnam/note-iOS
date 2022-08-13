//
//  UserNetwork+Rx.swift
//  NotesManager
//
//  Created by pnam on 28/07/2022.
//

@_implementationOnly import RxSwift
@_implementationOnly import Alamofire

// MARK: - ReactiveCompatible
extension AFUserNetwork: ReactiveCompatible {
    
}

// MARK: - AFUserNetwork
extension Reactive where Base: AFUserNetwork {
    func send<T: Request>(request: T) -> Single<T.Response> {
        Single.create { observer in
            let request = base.send(request: request) { result in
#if DEBUG
                print(result)
#endif
                switch result {
                case .success(let res):
                    observer(.success(res))
                case .failure(let error):
                    observer(.failure(error))
                }
            }
            return Disposables.create {
                request.cancel()
            }
        }
    }
}

