//
//  SettingViewController+Options.swift
//  NotesManager
//
//  Created by pnam on 05/08/2022.
//

@_implementationOnly import UIKit

extension SettingViewController {
    enum Option: CaseIterable {
        case language(value: String)
        case editProfile
        case changePassword
        
        static var allCases: [SettingViewController.Option] = [
            .language(value: ""),
            .editProfile,
            .changePassword
        ]
        
        var title: String {
            switch self {
            case .language:
                return Strings.language
            case .editProfile:
                return Strings.editProfile
            case .changePassword:
                return Strings.changePassword
            }
        }
        
        var isHiddenValueLabel: Bool {
            switch self {
            case .language:
                return false
            case .editProfile, .changePassword:
                return true
            }
        }
        
        var settingValue: String? {
            switch self {
            case .language(let value):
                return value
            case .editProfile, .changePassword:
                return nil
            }
        }
        
        var settingIcon: UIImage {
            switch self {
            case .language:
                return Asset.Assets.language.image
            case .editProfile:
                return Asset.Assets.editProfile.image
            case .changePassword:
                return Asset.Assets.password.image
            }
        }
    }
}

typealias SettingOption = SettingViewController.Option
