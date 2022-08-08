//
//  LanguagesViewModel.swift
//  NotesManager
//
//  Created by pnam on 08/08/2022.
//

import Foundation

protocol LanguagesViewModel {
    var language: Language { get set }
}

final class LanguagesViewModelImpl: LanguagesViewModel {
    var language: Language
    
    init(language: Language) {
        self.language = language
    }
}
