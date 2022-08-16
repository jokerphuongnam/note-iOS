//
//  SettingViewModel.swift
//  NotesManager
//
//  Created by pnam on 07/08/2022.
//

import Foundation

protocol SettingViewModel: AnyObject {
    var user: User! { get }
    func logout()
}

final class SettingViewModelImpl: SettingViewModel {
    private var useCase: SettingUseCase!
    
    var user: User!
    
    init(useCase: SettingUseCase) {
        self.useCase = useCase
        self.user = useCase.user
    }
    
    deinit {
        useCase = nil
    }
    
    func logout() {
        useCase.logout()
    }
}
