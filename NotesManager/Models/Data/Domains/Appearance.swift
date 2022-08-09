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
    case custom(startDarkMode: Int64, endDarkMode: Int64)
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
            return "\(Self.dateFormatter.string(from: .init(milliseconds: startDarkMode))) - \(Self.dateFormatter.string(from: .init(milliseconds: endDarkMode)))"
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
                startDarkMode: 946681200000, /// 06:00
                endDarkMode: 946724400000 /// 18:00
            )
        ]
    }
}

extension Appearance: Equatable {
    func equatable(compareAppearance rhs: Self) -> Bool {
        switch (self, rhs) {
        case (.light, .light),
            (.dark, .dark),
            (.systemAppearance, .systemAppearance),
            (.custom, .custom):
            return true
        default:
            return false
        }
    }
}
