//
//  AlertController+.swift
//  NotesManager
//
//  Created by pnam on 15/08/2022.
//

@_implementationOnly import UIKit

extension UIAlertAction {
    var titleTextColor: UIColor? {
        get {
            value(forKey: "titleTextColor") as! UIColor?
        }
        set {
            setValue(newValue, forKey: "titleTextColor")
        }
    }
}
