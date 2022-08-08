//
//  LanguagesViewController+CollectionView.swift
//  NotesManager
//
//  Created by pnam on 08/08/2022.
//

@_implementationOnly import UIKit

// MARK: - layout
extension LanguagesViewController {
    var layout: UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { [weak self] (numberOfSections, env) in
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
            section.contentInsets = .init(top: 0, leading: 16, bottom: 0, trailing: 16)
            return section
        }
    }
}

// MARK: - UICollectionViewDataSource
extension LanguagesViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        languages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Self.languageCellName, for: indexPath) as? LanguageCell {
            let language = languages[indexPath.item]
            cell.titleLabel.text = language.name
            cell.checkImageView.isHidden = viewModel.language != language
            return cell
        }
        fatalError()
    }
}

// MARK: - UICollectionViewDelegate
extension LanguagesViewController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.language = languages[indexPath.item]
        collectionView.reloadData()
    }
}
