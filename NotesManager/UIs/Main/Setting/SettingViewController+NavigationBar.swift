//
//  SettingViewController+NavigationBar.swift
//  NotesManager
//
//  Created by pnam on 05/08/2022.
//

@_implementationOnly import UIKit

extension SettingViewController {
    func setupNavigationBar() {
        title = Strings.setting
        navigationController?.navigationBar.update(backroundColor: Asset.Colors.background.color, titleColor: Asset.Colors.text.color)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = Asset.Colors.main.color
    }
}
