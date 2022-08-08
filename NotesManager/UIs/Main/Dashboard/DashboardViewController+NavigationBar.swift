//
//  DashboardViewController+NavigationBar.swift
//  NotesManager
//
//  Created by pnam on 04/08/2022.
//

@_implementationOnly import UIKit

extension DashboardViewController {
    func setupNavigationBar() {
        title = Strings.dashboard
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.leftBarButtonItems = [settingButton]
        navigationItem.rightBarButtonItems = [addButton, layoutChangeButton]
        
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.delegate = self
        navigationItem.searchController = search
        navigationController?.navigationBar.scrollEdgeAppearance?.shadowColor = .clear
        navigationController?.navigationBar.tintColor = Asset.Colors.main.color
    }
}
