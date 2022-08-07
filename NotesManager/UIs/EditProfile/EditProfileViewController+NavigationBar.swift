//
//  EditProfileViewController+NavigationBar.swift
//  NotesManager
//
//  Created by pnam on 07/08/2022.
//

@_implementationOnly import UIKit

extension EditProfileViewController {
    func setupNavigationBar() {
        title = Strings.editProfile
        navigationController?.navigationBar.update(backroundColor: Asset.Colors.background.color, titleColor: Asset.Colors.text.color)
        navigationController?.navigationBar.prefersLargeTitles
        navigationController?.navigationBar.tintColor = Asset.Colors.main.color
        
    }
}
