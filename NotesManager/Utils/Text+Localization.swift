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
            text ?? ""
        }
    }
}

extension UIButton {
    @IBInspectable var localizeTitle: String {
        set(value) {
            setTitle(NSLocalizedString(value, comment: ""), for: .normal)
        }
        get {
            titleLabel?.text ?? ""
        }
    }
}

extension UITextField {
    @IBInspectable var localizePlaceholder: String {
        set(value) {
            placeholder = NSLocalizedString(value, comment: "")
        }
        get {
            placeholder ?? ""
        }
    }
    
    @IBInspectable var localizeText: String {
        set(value) {
            text = NSLocalizedString(value, comment: "")
        }
        get {
            text ?? ""
        }
    }
}
