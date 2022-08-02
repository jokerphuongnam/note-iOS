//
//  RegisterViewController+NavigationBar.swift
//  NotesManager
//
//  Created by pnam on 02/08/2022.
//

@_implementationOnly import UIKit

extension RegisterViewController: BaseNavigationBar {
    func setupNavigationBar() {
        setupTitle()
    }
    
    func setupTitle() {
        title = Strings.register
    }
}
