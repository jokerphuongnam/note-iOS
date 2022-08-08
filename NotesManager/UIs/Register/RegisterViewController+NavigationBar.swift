//
//  RegisterViewController+NavigationBar.swift
//  NotesManager
//
//  Created by pnam on 02/08/2022.
//

@_implementationOnly import UIKit

extension RegisterViewController {
    func setupNavigationBar() {
        title = Strings.login
        navigationController?.navigationBar.scrollEdgeAppearance?.shadowColor = .clear
        navigationController?.navigationBar.tintColor = Asset.Colors.main.color
        if let font: UIFont = .helveticalNeueBoldItalic(size: 17) {
            navigationController?.navigationBar.titleTextAttributes = [.font: font]
        }
    }
}
