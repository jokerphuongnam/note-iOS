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
        container.register(Session.self) { resolve in
            let configuration = URLSessionConfiguration.default
            let timeout = 60
            configuration.timeoutIntervalForResource = TimeInterval(timeout)
            configuration.timeoutIntervalForRequest = TimeInterval(timeout)
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
