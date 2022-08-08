//
//  Appearance.swift
//  NotesManager
//
//  Created by pnam on 08/08/2022.
//

import Foundation

enum Appearance {
    case light
    case dark
    case systemAppearance
    case custom(startDarkMode: Int, endDarkMode: Int)
}

extension Appearance {
    private static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter
    }()
    
    var mode: String {
        switch self {
        case .light:
            return Strings.light
        case .dark:
            return Strings.dark
        case .systemAppearance:
            return Strings.systemAppearance
        case .custom(let startDarkMode, let endDarkMode):
            return "\(Self.dateFormatter.string(from: .init(milliseconds: Int64(startDarkMode)))) - \(Self.dateFormatter.string(from: .init(milliseconds: Int64(endDarkMode))))"
        }
    }
}

extension Appearance: CaseIterable {
    static var allCases: [Appearance] {
        [
            .light,
            .dark,
            .systemAppearance,
            .custom(
                startDarkMode: 943201200, /// 06:00
                endDarkMode: 943215600 /// 18:00
            )
        ]
    }
}

extension Appearance: Equatable {
    
}
