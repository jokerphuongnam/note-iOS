//
//  MockSession.swift
//  NotesManager StagingTests
//
//  Created by pnam on 29/07/2022.
//

@_implementationOnly import Alamofire
@testable import NotesManager_Staging

final class MockSession: Session {
    var endPoint: String?
    var expectedDataType: String?
    var method: HTTPMethod?
    var parameters: Parameters?
    var httpHeaders: HTTPHeaders?
    
    @discardableResult
    override func request(
        _ convertible: URLConvertible,
        method: HTTPMethod = .get,
        parameters: Parameters? = nil,
        encoding: ParameterEncoding = URLEncoding.default,
        headers: HTTPHeaders? = nil,
        interceptor: RequestInterceptor? = nil,
        requestModifier: RequestModifier? = nil
    ) -> DataRequest {
        self.endPoint = try? convertible.asURL().path
        self.expectedDataType = String(describing: expectedDataType.self)
        self.method = method
        self.parameters = parameters
        self.httpHeaders = headers
        return super.request(
            convertible,
            method: method,
            parameters: parameters,
            encoding: encoding,
            headers: headers,
            interceptor: nil,
            requestModifier: requestModifier
        )
    }
}
