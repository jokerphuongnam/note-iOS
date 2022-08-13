//
//  NetworkAssembly.swift
//  MoveX
//
//  Created by pnam on 17/07/2022.
//

@_implementationOnly import Swinject
@_implementationOnly import SwinjectAutoregistration
@_implementationOnly import Alamofire

struct NetworkAssembly: Assembly {
    func assemble(container: Container) {
        container.autoregister(RequestInterceptor.self, name: .tokenInterceptor, initializer: TokenInterceptor.init)
        
        container.register(Session.self) { resolve in
            let configuration = URLSessionConfiguration.default
            configuration.timeoutIntervalForResource = TimeInterval(.networkTimeOut)
            configuration.timeoutIntervalForRequest = TimeInterval(.networkTimeOut)
            configuration.waitsForConnectivity = true
            configuration.allowsCellularAccess = false
            configuration.allowsConstrainedNetworkAccess = false
            configuration.allowsExpensiveNetworkAccess = false
            return Session(configuration: configuration)
        }
        .inObjectScope(.container)
        
        container.autoregister(UserNetwork.self, initializer: AFUserNetwork.init)
            .inObjectScope(.container)
        
        container.autoregister(NoteNetwork.self, initializer: AFNoteNetwork.init)
            .inObjectScope(.container)
    }
}
