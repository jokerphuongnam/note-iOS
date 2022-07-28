//
//  BaseAFNetwork.swift
//  NotesManager
//
//  Created by pnam on 28/07/2022.
//

@_implementationOnly import Alamofire
@_implementationOnly import RxSwift

protocol BaseAFNetwork: AnyObject {
    var session: Session { get }
}

extension BaseAFNetwork {
    @discardableResult
    func send<T: Request>(
        request: T,
        completion: @escaping (Result<ApiResponse<T.Response>, ApiError>) -> ()
    ) -> DataRequest {
        session.request(
            request.url,
            method: request.method,
            parameters: request.parameters,
            encoding: request.encoding,
            headers: request.httpHeaderFields,
            interceptor: request.interceptor
        )
        .cURLDescription(on: DispatchQueue.init(label: "\(self.self)", qos: .background)) { [weak self] description in
            guard self != nil else { return }
#if DEBUG
            print("Request \(description)")
#endif
        }
        .responseDecodable(of: T.Response.self) { [weak self] response in
            guard self != nil else {
                completion(.failure(ApiError.dataNotExist))
                return
            }
            switch response.error {
            case .some(let error):
                if let error = error.underlyingError as? URLError {
                    switch error.code {
                    case .timedOut:
                        completion(.failure(.timeout))
                    default:
                        completion(.failure(.unknownError(ResponseError(error.localizedDescription))))
                    }
                    return
                } else {
                    switch error {
                    case .sessionTaskFailed(error: let err):
                        completion(.failure(.connectionFailed(err)))
                    default:
                        completion(.failure(.unknownError(ResponseError(error.localizedDescription))))
                    }
                    return
                }
            case .none:
                guard let data = response.data else {
                    completion(.failure(.dataNotExist))
                    return
                }

                guard let statusCode = response.response?.statusCode else {
                    completion(.failure(.statusCodeNotExist))
                    return
                }
                switch statusCode {
                case 200..<500:
                    do {
                        let res = try JSONDecoder().decode(ApiResponse<T.Response>.self, from: data)
                        if res.status {
                            completion(.success(res))
                        } else {
                            completion(.failure(.unknownError(.init(status: res.status, message: res.message))))
                        }
                    } catch  {
                        completion(.failure(.unknownError(ResponseError(error.localizedDescription))))
                    }
                default:
                    completion(.failure(.otherError(.init(false))))
                }
            }
        }
    }
}
