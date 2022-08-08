//
//  ChangePasswordViewController+NavigationBar.swift
//  NotesManager
//
//  Created by pnam on 07/08/2022.
//

import Foundation

extension ChangePasswordViewController {
    func setupNavigationBar() {
        title = Strings.changePassword
        navigationController?.navigationBar.scrollEdgeAppearance?.shadowColor = .clear
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = Asset.Colors.main.color
    }
}
