//
//  NoteManagerAssembler.swift
//  MoveX
//
//  Created by pnam on 17/07/2022.
//

@_implementationOnly import Swinject
@_implementationOnly import SwinjectAutoregistration

extension Assembler {
    static let shared: Assembler = {
        let assembler: Assembler = .init([
            AppAssembly(),
            UseCasesAssembly(),
            RepositoriesAssembly(),
            NetworkAssembly(),
            LocalAssembly()
        ])
        return assembler
    }()
}


class NoteManagerAssembler {
    static func inject<Service>() -> Service {
        Assembler.shared.resolver~>
    }
    
    static func inject<Service>(service: Service.Type) -> Service {
        Assembler.shared.resolver~>(service)
    }
    
    static func inject<Service>(name: String) -> Service {
        Assembler.shared.resolver~>(service: Service.self, name: name)
    }
    
    static func inject<Service>(service: Service.Type, name: String) -> Service {
        Assembler.shared.resolver~>(service: service, name: name)
    }
    
    static func inject<Service, Arg1>(service: Service.Type, argument: Arg1) -> Service {
        Assembler.shared.resolver~>(service: service, argument: argument)
    }
    
    static func inject<Service, Arg1>(service: Service.Type, name: String, argument: Arg1) -> Service {
        Assembler.shared.resolver~>(service: service, name: name, argument: argument)
    }
}
