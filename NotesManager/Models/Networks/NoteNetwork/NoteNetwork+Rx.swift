//
//  NoteNetwork+Rx.swift
//  NotesManager
//
//  Created by pnam on 28/07/2022.
//

@_implementationOnly import RxSwift
@_implementationOnly import Alamofire

extension AFNoteNetwork: ReactiveCompatible {

}

extension Reactive where Base: AFNoteNetwork {
    func send<T: Request>(request: T) -> Single<T.Response> {
        Single.create { observer in
            let request = base.send(request: request) { result in
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
