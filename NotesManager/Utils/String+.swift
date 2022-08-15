//
//  String+.swift
//  NotesManager
//
//  Created by pnam on 02/08/2022.
//

import Foundation

extension String {
    // MARK: - UIKit Key
    static let contentAlertViewControllerKey: Self = "contentViewController"
    
    // MARK: - XCConfig
    static func infoKey(_ key: String) -> String {
        ((Bundle.main.infoDictionary?[key] as? String)?.replacingOccurrences(of: "\\", with: ""))!
    }
    
    static let baseUrl: Self = .infoKey("Base Url")
    
    // MARK: - UserDefaults
    static let userDefaultUser: Self = "user"
    static let userDefaultTempNoteWhenInsert: Self = "tempNoteWhenInsert"
    static let userDefaultAccount: Self = "account"
    static let userDefaultAccessToken: Self = "accessToken"
    
    // MARK: - Dependency Injection
    static let tokenInterceptor: Self = "tokenInterceptor"
}
