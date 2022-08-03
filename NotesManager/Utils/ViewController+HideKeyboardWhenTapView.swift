//
//  ViewController+HideKeyboardWhenTapView.swift
//  NotesManager
//
//  Created by pnam on 02/08/2022.
//

@_implementationOnly import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}
