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
        set {
            setTitle(NSLocalizedString(newValue, comment: ""), for: .normal)
        }
        get {
            titleLabel?.text ?? ""
        }
    }
}

extension UITextField {
    @IBInspectable var localizePlaceholder: String {
        set {
            placeholder = NSLocalizedString(newValue, comment: "")
        }
        get {
            placeholder ?? ""
        }
    }
    
    @IBInspectable var localizeText: String {
        set {
            text = NSLocalizedString(newValue, comment: "")
        }
        get {
            text ?? ""
        }
    }
}

extension UITextView {
    @IBInspectable var localizePlaceholder: String {
        set {
            placeholder = NSLocalizedString(newValue, comment: "")
        }
        get {
            placeholder
        }
    }
    
    @IBInspectable var localizeText: String {
        set {
            text = NSLocalizedString(newValue, comment: "")
        }
        get {
            text ?? ""
        }
    }
}
