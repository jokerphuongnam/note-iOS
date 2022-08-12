//
//  RepositoriesAssembly.swift
//  MoveX
//
//  Created by pnam on 17/07/2022.
//

@_implementationOnly import Swinject
@_implementationOnly import SwinjectAutoregistration

struct RepositoriesAssembly: Assembly {
    func assemble(container: Container) {
        container.autoregister(UserRepository.self, initializer: UserRepositoryImpl.init)
            .inObjectScope(.container)
    }
}
