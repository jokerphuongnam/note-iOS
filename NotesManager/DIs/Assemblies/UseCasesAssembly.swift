//
//  AppAssembly.swift
//  MoveX
//
//  Created by pnam on 17/07/2022.
//

@_implementationOnly import Swinject
@_implementationOnly import SwinjectAutoregistration

struct UseCasesAssembly: Assembly {
    func assemble(container: Container) {
        container.autoregister(LoginUseCase.self, initializer: LoginUseCaseImpl.init)
            .inObjectScope(.container)
    }
}
