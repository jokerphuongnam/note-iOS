//
//  AppAssembly.swift
//  NotesManager
//
//  Created by pnam on 12/08/2022.
//

@_implementationOnly import Swinject
@_implementationOnly import SwinjectAutoregistration

struct AppAssembly: Assembly {
    func assemble(container: Container) {
        container.autoregister(JSONDecoder.self, initializer: JSONDecoder.init)
            .inObjectScope(.container)
        container.autoregister(JSONEncoder.self, initializer: JSONEncoder.init)
            .inObjectScope(.container)
    }
}
