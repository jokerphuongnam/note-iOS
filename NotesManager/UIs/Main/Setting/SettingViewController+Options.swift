//
//  SettingViewController+Options.swift
//  NotesManager
//
//  Created by pnam on 05/08/2022.
//

@_implementationOnly import UIKit

extension SettingViewController {
    enum Option: CaseIterable {
        case language(currentLanguage: Language)
        case appearance(currentAppearance: Appearance)
        case editProfile
        case changePassword
        
        static var allCases: [SettingViewController.Option] = [
            .language(currentLanguage: .en),
            .appearance(currentAppearance: .systemAppearance),
            .editProfile,
            .changePassword
        ]
        
        var title: String {
            switch self {
            case .language:
                return Strings.language
            case .appearance:
                return Strings.appearance
            case .editProfile:
                return Strings.editProfile
            case .changePassword:
                return Strings.changePassword
            }
        }
        
        var isHiddenValueLabel: Bool {
            switch self {
            case .language, .appearance:
                return false
            case .editProfile, .changePassword:
                return true
            }
        }
        
        var settingValue: String? {
            switch self {
            case .language(let currentLanguage):
                return currentLanguage.name
            case .appearance(currentAppearance: let appearance):
                return appearance.mode
            case .editProfile, .changePassword:
                return nil
            }
        }
        
        var settingIcon: UIImage {
            switch self {
            case .language:
                return Asset.Assets.language.image
            case .appearance:
                return Asset.Assets.iphoneScreen.image
            case .editProfile:
                return Asset.Assets.editProfile.image
            case .changePassword:
                return Asset.Assets.password.image
            }
        }
    }
}

typealias SettingOption = SettingViewController.Option
