//
//  LoginViewController+NavigationBar.swift
//  NotesManager
//
//  Created by pnam on 02/08/2022.
//

@_implementationOnly import UIKit

extension LoginViewController: BaseNavigationBar {
    func setupNavigationBar() {
        setupTitle()
    }
    
    private func setupTitle() {
        title = L10n.login
    }
}
