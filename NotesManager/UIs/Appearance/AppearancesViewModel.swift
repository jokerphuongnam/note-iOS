//
//  AppearancesViewModel.swift
//  NotesManager
//
//  Created by pnam on 08/08/2022.
//

import Foundation

protocol AppearancesViewModel {
    var appearance: Appearance { get set }
}

final class AppearancesViewModelImpl: AppearancesViewModel {
    var appearance: Appearance
    
    init(appearance: Appearance) {
        self.appearance = appearance
    }
}
