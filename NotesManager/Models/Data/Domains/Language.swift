//
//  Language.swift
//  NotesManager
//
//  Created by pnam on 08/08/2022.
//

import Foundation

enum Language {
    init?(language: String) {
        switch language {
        case Strings.systemLanguage:
            self = .systemLanguage
        case "English":
            self = .en
        case "Việt Nam":
            self = .vi
        case "Français":
            self = .fr
        case "简体中文":
            self = .cn(.simplified)
        case "繁體中文":
            self = .cn(.tranditional)
        case "日本":
            self = .jp
        case "한국인":
            self = .kr
        default:
            return nil
        }
    }
    
    case systemLanguage
    case en
    case vi
    case fr
    case cn(China)
    case jp
    case kr
    
    
    var name: String {
        switch self {
        case .systemLanguage:
            return Strings.systemLanguage
        case .en:
            return "English"
        case .vi:
            return "Việt Nam"
        case .fr:
            return "Français"
        case .cn(let china):
            switch china {
            case .simplified:
                return "简体中文"
            case .tranditional:
                return "繁體中文"
            }
        case .jp:
            return "日本"
        case .kr:
            return "한국인"
        }
    }
}

extension Language {
    enum China {
        case simplified
        case tranditional
    }
}

extension Language: CaseIterable {
    static var allCases: [Language] {
        [
            .systemLanguage,
            .en,
            .vi,
            .fr,
            .cn(.simplified),
            .cn(.tranditional),
            .jp,
            .kr
        ]
    }
}

extension Language {
    var code: String {
        switch self {
        case .systemLanguage:
            return ""
        case .en:
            return "en"
        case .vi:
            return "vi"
        case .fr:
            return "fr"
        case .cn(let china):
            switch china {
            case .simplified:
                return "zh-Hans"
            case .tranditional:
                return "zh-Hant"
            }
        case .jp:
            return "jp"
        case .kr:
            return "ko"
        }
    }
}

extension Language: Equatable {
    
}
