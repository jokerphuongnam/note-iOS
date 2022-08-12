//
//  BaseAFNetwork.swift
//  NotesManager
//
//  Created by pnam on 28/07/2022.
//

@_implementationOnly import Alamofire
@_implementationOnly import RxSwift

protocol BaseAFNetwork: AnyObject {
    var session: Session! { get }
    var decoder: JSONDecoder! { get }
}

extension BaseAFNetwork {
    @discardableResult
    func send<T: Request>(
        request: T,
        completion: @escaping (Result<T.Response, Error>) -> ()
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
            guard self != nil else {
                completion(.failure(NError.ownerNil))
                return
            }
#if DEBUG
            print("Request \(description)")
#endif
        }
        .responseDecodable(of: T.Response.self) { [weak self] response in
            guard let self = self else {
                completion(.failure(NError.ownerNil))
                return
            }
            guard let data = response.data else {
                completion(.failure(ApiError.dataNotExist))
                return
            }
            
            guard let statusCode = response.response?.statusCode else {
                completion(.failure(ApiError.statusCodeNotExist))
                return
            }
            switch statusCode {
            case 200..<500:
                do {
                    let res = try self.decoder.decode(ApiResponse<T.Response>.self, from: data)
                    if res.status {
                        completion(.success(res.data))
                    } else {
                        completion(.failure(ApiError.unknownError(.init(status: res.status, message: res.message, statusCode: statusCode))))
                    }
                } catch  {
                    completion(.failure(ApiError.unknownError(ResponseError(error.localizedDescription, statusCode: statusCode))))
                }
            default:
                completion(.failure(ApiError.otherError(.init(false, statusCode: statusCode))))
            }
        }
    }
}
