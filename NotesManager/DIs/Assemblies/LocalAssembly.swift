//
//  LocalAssembly.swift
//  MoveX
//
//  Created by pnam on 17/07/2022.
//

@_implementationOnly import Swinject
@_implementationOnly import SwinjectAutoregistration
@_implementationOnly import RealmSwift

struct LocalAssembly: Assembly {
    func assemble(container: Container) {
        container.register(Realm?.self) { resolve in
            do {
                return try Realm()
            } catch {
                print(error)
                return nil
            }
        }
        .inObjectScope(.container)
        
        container.register(UserDefaults.self) { resolve in
            UserDefaults.standard
        }
        .inObjectScope(.container)
        
        container.autoregister(UserDefaultsManager.self, initializer: UserDefaultsManagerImpl.init)
            .inObjectScope(.container)
        
        container.autoregister(KeyChainManager.self, initializer: KeyChainManagerImpl.init)
            .inObjectScope(.container)
        
        container.autoregister(UserLocal.self, initializer: UserLocalImpl.init)
            .inObjectScope(.container)
    }
}
