//
//  Text+Localization.swift
//  NotesManager
//
//  Created by pnam on 02/08/2022.
//

@_implementationOnly import UIKit

extension UILabel {
    @IBInspectable var localizeText: String {
        set(value) {
            text = NSLocalizedString(value, comment: "")
        }
        get {
            return ""
        }
    }
}

extension UIButton {
    @IBInspectable var localizeTitle: String {
        set(value) {
            setTitle(NSLocalizedString(value, comment: ""), for: .normal)
        }
        get {
            return ""
        }
    }
}

extension UITextField {
    @IBInspectable var localizePlaceholder: String {
        set(value) {
            placeholder = NSLocalizedString(value, comment: "")
        }
        get {
            return ""
        }
    }
    
    @IBInspectable var localizeText: String {
        set(value) {
            text = NSLocalizedString(value, comment: "")
            L10n
        }
        get {
            return ""
        }
    }
}
