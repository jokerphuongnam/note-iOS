//
//  DashboardViewController+NavigationBar.swift
//  NotesManager
//
//  Created by pnam on 04/08/2022.
//

@_implementationOnly import UIKit

extension DashboardViewController {
    func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.update(backroundColor: Asset.Colors.background.color, titleColor: Asset.Colors.text.color)
        navigationItem.leftBarButtonItems = [settingButton]
        navigationItem.rightBarButtonItems = [addButton, layoutChangeButton]
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.delegate = self
        navigationItem.searchController = search
        title = Strings.dashboard
        navigationController?.navigationBar.update(
            backroundColor: Asset.Colors.background.color,
            titleColor: Asset.Colors.text.color
        )
    }
}
