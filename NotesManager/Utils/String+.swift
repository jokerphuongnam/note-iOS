//
//  String+.swift
//  MoveX
//
//  Created by pnam on 11/07/2022.
//

import Foundation

extension String {
    static func infoKey(_ key: String) -> String {
        ((Bundle.main.infoDictionary?[key] as? String)?.replacingOccurrences(of: "\\", with: ""))!
    }
}
