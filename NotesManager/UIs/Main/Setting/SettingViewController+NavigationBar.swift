//
//  SettingViewController+NavigationBar.swift
//  NotesManager
//
//  Created by pnam on 05/08/2022.
//

@_implementationOnly import UIKit

extension SettingViewController {
    func setupNavigationBar() {
        configTitle()
        navigationController?.navigationBar.update(backroundColor: Asset.Colors.background.color, titleColor: Asset.Colors.text.color)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = Asset.Colors.main.color
    }
    
    func configTitle() {
        if let user = viewModel.user {
            setNavigationBarTitle(largeTitle: user.name, collapsedTitle: user.email)
        } else {
            title = Strings.setting
        }
    }
}
