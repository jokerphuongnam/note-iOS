//
//  MainViewController+ChildDelegate.swift
//  NotesManager
//
//  Created by pnam on 04/08/2022.
//

@_implementationOnly import UIKit

//MARK: - DashboardViewControllerDelegate
extension MainViewController: DashboardViewControllerDelegate {
    func dashboard(_ viewController: DashboardViewController, viewDidAppear animated: Bool) {
        
    }
}

//MARK: - SettingViewControllerDelegate
extension MainViewController: SettingViewControllerDelegate {
    func setting(_ viewController: SettingViewController, viewDidAppear animated: Bool) {
        navigationItem.rightBarButtonItems = []
    }
}
