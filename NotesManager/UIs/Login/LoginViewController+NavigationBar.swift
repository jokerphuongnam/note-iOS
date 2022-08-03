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
        setupSimpleNavigationBar()
    }
    
    private func setupSimpleNavigationBar() {
        title = Strings.login
        navigationController?.navigationBar.update(backroundColor: Asset.Colors.main.color)
        navigationController?.navigationBar.scrollEdgeAppearance?.shadowColor = .clear
        if let font: UIFont = .helveticalNeueBoldItalic(size: 17) {
            navigationController?.navigationBar.titleTextAttributes = [.font: font]
        }
    }
}
