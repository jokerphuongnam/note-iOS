//
//  Request.swift
//  NotesManager
//
//  Created by pnam on 28/07/2022.
//

@_implementationOnly import Alamofire

protocol Request where Self.Response: Decodable {
    associatedtype Response

    var baseURL: URL { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var url: URL { get }
    var parameters: Parameters { get }
    var httpHeaderFields: HTTPHeaders { get }
    var encoding: URLEncoding { get }
    var interceptor: Interceptor? { get }
}
