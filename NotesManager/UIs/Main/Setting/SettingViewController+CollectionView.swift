//
//  SettingViewController+CollectionView.swift
//  NotesManager
//
//  Created by pnam on 05/08/2022.
//

@_implementationOnly import UIKit

//MARK: - layout
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
        if let logoutView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Self.logoutViewName, for: indexPath) as? LogoutView {
            logoutView.delegate = self
            return logoutView
        }
        fatalError()
    }
}

// MARK: - UICollectionViewDelegate
extension SettingViewController {
    
}

// MARK: - LogoutViewDelegate
extension SettingViewController: LogoutViewDelegate {
    func logoutView(_ logoutView: LogoutView, logout sender: UIButton, forEvent event: UIEvent) {
        let viewController = LoginViewController()
        let navigation = UINavigationController(rootViewController: viewController)
        navigation.modalPresentationStyle = .fullScreen
        
        navigationController?.present(navigation, animated: true) { [weak self] in
            guard let self = self, let window = UIWindow.key else { return }
            self.navigationController?.popToRootViewController(animated: false)
            let viewController = LoginViewController()
            let navigation = UINavigationController(rootViewController: viewController)
            window.rootViewController = navigation
        }
    }
}
