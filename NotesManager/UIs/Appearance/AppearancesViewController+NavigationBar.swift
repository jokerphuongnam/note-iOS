//
//  AppearancesViewController+NavigationBar.swift
//  NotesManager
//
//  Created by pnam on 08/08/2022.
//

import Foundation

extension AppearancesViewController {
    func setupNavigationBar() {
        title = Strings.appearance
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.scrollEdgeAppearance?.shadowColor = .clear
        navigationController?.navigationBar.tintColor = Asset.Colors.main.color
    }
}
