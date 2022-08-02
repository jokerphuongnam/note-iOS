//
//  LoginViewController+NavigationBar.swift
//  NotesManager
//
//  Created by pnam on 02/08/2022.
//

@_implementationOnly import UIKit

extension LoginViewController: BaseNavigationBar {
    func setupNavigationBar() {
        
    }
    
    func resumeNavigationBar() {
        setupNavigationBar()
    }
    
    private func setupSimpleNavigationBar() {
        title = Strings.login
        navigationController?.navigationBar.update(backroundColor: Asset.Colors.main.color)
        navigationController?.navigationBar.removeBottomShadow()
    }
}
