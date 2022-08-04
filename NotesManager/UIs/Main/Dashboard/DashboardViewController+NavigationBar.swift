//
//  DashboardViewController+NavigationBar.swift
//  NotesManager
//
//  Created by pnam on 04/08/2022.
//

import Foundation

extension DashboardViewController: BaseNavigationBar {
    func setupNavigationBar() {
        
    }
    
    func resumeNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        setNavigationBarTitle(largeTitle: "Large Dashboard", collapsedTitle: "Collapsed Dashboard")
        navigationController?.navigationBar.update(backroundColor: Asset.Colors.background.color, titleColor: Asset.Colors.text.color)
        navigationItem.rightBarButtonItems = [addButton]
    }
}
