//
//  SettingViewModel.swift
//  NotesManager
//
//  Created by pnam on 07/08/2022.
//

import Foundation

protocol SettingViewModel: AnyObject {
    var user: User! { get set }
}

final class SettingViewModelImpl: SettingViewModel {
    var user: User!
    init() {
        self.user = .init(id: "", email: "phuongnamp99@gmail.com", name: "P.Nam", gender: .male)
    }
}
