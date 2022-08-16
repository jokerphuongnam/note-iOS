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
        
        container.autoregister(DashboardUseCase.self, initializer: DashboardUseCaseImpl.init)
            .inObjectScope(.container)
        
        container.autoregister(ConfigNoteUseCase.self, initializer: ConfigNoteUseCaseImpl.init)
            .inObjectScope(.container)
        
        container.autoregister(NoteDetailUseCase.self, initializer: NoteDetailUseCaseImpl.init)
            .inObjectScope(.container)
        
        container.autoregister(SettingUseCase.self, initializer: SettingUseCaseImpl.init)
            .inObjectScope(.container)
        
        container.autoregister(ChangePasswordUseCase.self, initializer: ChangePasswordUseCaseImpl.init)
            .inObjectScope(.container)
        
        container.autoregister(EditProfileUseCase.self, initializer: EditProfileUseCaseImpl.init)
            .inObjectScope(.container)
        
        container.autoregister(RegisterUseCase.self, initializer: RegisterUseCaseImpl.init)
            .inObjectScope(.container)
    }
}
