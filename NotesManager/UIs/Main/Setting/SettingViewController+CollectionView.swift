//
//  SettingViewController+CollectionView.swift
//  NotesManager
//
//  Created by pnam on 05/08/2022.
//

@_implementationOnly import UIKit

// MARK: - layout
extension SettingViewController {
    var layout: UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { [weak self] (numberOfSection ,env) in
            guard let self = self else { return nil }
            let item = NSCollectionLayoutItem(
                layoutSize: .init(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1)
                )
            )
            let group = NSCollectionLayoutGroup.vertical(
                layoutSize: .init(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .absolute(50)
                ),
                subitems: [item]
            )
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 16
            section.contentInsets = .init(top: 0, leading: 16, bottom: 16, trailing: 16)
            section.boundarySupplementaryItems = [
                .init(
                    layoutSize: .init(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .absolute(80)
                    ),
                    elementKind: Self.logoutViewName,
                    alignment: .bottom
                )
            ]
            return section
        }
    }
}

// MARK: - UICollectionViewDataSource
extension SettingViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        options.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Self.settingCellName, for: indexPath) as? SettingCell {
            cell.option = options[indexPath.item]
            return cell
        }
        fatalError()
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if let v = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Self.logoutViewName, for: indexPath) as? LogoutView {
            v.delegate = self
            return v
        }
        fatalError()
    }
}

// MARK: - UICollectionViewDelegate
extension SettingViewController {
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        configTitle()
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch options[indexPath.item] {
        case .language(currentLanguage: let language):
            let viewModel: LanguagesViewModel = LanguagesViewModelImpl(language: language)
            let viewController = LanguagesViewController(viewModel: viewModel)
            navigationController?.pushViewController(viewController, animated: true)
        case .appearance(currentAppearance: let appearance):
            let viewModel: AppearancesViewModel = AppearancesViewModelImpl(appearance: appearance)
            let viewController = AppearancesViewController(viewModel: viewModel)
            navigationController?.pushViewController(viewController, animated: true)
        case .editProfile:
            let viewModel: EditProfileViewModel = EditProfileViewModelImpl(user: viewModel.user)
            let viewController = EditProfileViewController(viewModel: viewModel)
            navigationController?.pushViewController(viewController, animated: true)
        case .changePassword:
            let viewModel: ChangePasswordViewModel = ChangePasswordViewModelImpl(user: viewModel.user)
            let viewController = ChangePasswordViewController(viewModel: viewModel)
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
}

// MARK: - LogoutViewDelegate
extension SettingViewController: LogoutViewDelegate {
    func logoutView(_ logoutView: LogoutView, logout sender: UIButton, forEvent event: UIEvent) {
        let viewModel: LoginViewModel = LoginViewModelImpl(useCase: NoteManagerAssembler.inject())
        let viewController = LoginViewController(viewModel: viewModel)
        let navigation = UINavigationController(rootViewController: viewController)
        UIWindow.key?.changeRootViewControllerPresent(rootViewController: navigation)
    }
}
