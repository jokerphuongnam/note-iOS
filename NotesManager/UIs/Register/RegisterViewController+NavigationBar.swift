//
//  RegisterViewController+NavigationBar.swift
//  NotesManager
//
//  Created by pnam on 02/08/2022.
//

@_implementationOnly import UIKit

extension RegisterViewController: BaseNavigationBar {
    func setupNavigationBar() {
        
    }
    
    func resumeNavigationBar() {
        setupSimpleNavigationBar()
    }
    
    private func setupSimpleNavigationBar() {
        title = Strings.login
        navigationController?.navigationBar.update(backroundColor: Asset.Colors.background.color)
        navigationController?.navigationBar.scrollEdgeAppearance?.shadowColor = .clear
        if let font: UIFont = .helveticalNeueBoldItalic(size: 17) {
            navigationController?.navigationBar.titleTextAttributes = [.font: font]
        }
    }
}
