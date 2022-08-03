//
//  String+.swift
//  NotesManager
//
//  Created by pnam on 02/08/2022.
//

import Foundation

extension String {
    static func infoKey(_ key: String) -> String {
        ((Bundle.main.infoDictionary?[key] as? String)?.replacingOccurrences(of: "\\", with: ""))!
    }
    
    static let baseUrl: Self = .infoKey("Base Url")
}
