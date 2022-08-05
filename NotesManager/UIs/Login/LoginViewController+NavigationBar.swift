//
//  LoginViewController+NavigationBar.swift
//  NotesManager
//
//  Created by pnam on 02/08/2022.
//

@_implementationOnly import UIKit

extension LoginViewController {
    func setupNavigationBar() {
        title = Strings.login
        navigationController?.navigationBar.update(backroundColor: Asset.Colors.main.color)
        navigationController?.navigationBar.scrollEdgeAppearance?.shadowColor = .clear
        if let font: UIFont = .helveticalNeueBoldItalic(size: 17) {
            navigationController?.navigationBar.titleTextAttributes = [.font: font]
        }
    }
}
