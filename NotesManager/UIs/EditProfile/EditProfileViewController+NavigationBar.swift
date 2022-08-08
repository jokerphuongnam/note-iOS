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
        navigationController?.navigationBar.scrollEdgeAppearance?.shadowColor = .clear
        navigationController?.navigationBar.tintColor = Asset.Colors.main.color
        
    }
}
