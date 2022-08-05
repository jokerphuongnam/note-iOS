//
//  DashboardViewController+CollectionView.swift
//  NotesManager
//
//  Created by pnam on 04/08/2022.
//

@_implementationOnly import UIKit

//MARK: - layout
extension DashboardViewController {
    var layout: UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { [weak self] (numberOfSection, env) in
            guard let self = self else {
                return nil
            }
            switch self.layoutType {
            case .vertical:
                let item = NSCollectionLayoutItem(
                    layoutSize: .init(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .fractionalHeight(1)
                    )
                )
                item.contentInsets.leading = 8
                item.contentInsets.trailing = 8
                let group = NSCollectionLayoutGroup.vertical(
                    layoutSize: .init(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .absolute(50)
                    ),
                    subitems: [item]
                )
                let section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 16
                return section
            case .grid:
                let fraction: CGFloat = 1 / 2
                let item = NSCollectionLayoutItem(
                    layoutSize: .init(
                        widthDimension: .fractionalWidth(fraction),
                        heightDimension: .fractionalHeight(1)
                    )
                )
                item.contentInsets.leading = 8
                item.contentInsets.trailing = 8
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: .init(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .fractionalWidth(fraction)
                    ),
                    subitems: [item]
                )
                let section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 16
                return section
            }
        }
    }
    
    enum DashboardLayout {
        case vertical
        case grid
    }
}

// MARK: - UICollectionViewDataSource
extension DashboardViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.notes?.data.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch layoutType {
        case .vertical:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Self.noteVerticalCellName, for: indexPath) as? NoteVerticalCell {
                if let notes = viewModel.notes {
                    cell.note = notes.data[indexPath.item]
                }
                return cell
            }
        case .grid:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Self.noteGridCellName, for: indexPath) as? NoteGridCell {
                if let notes = viewModel.notes {
                    cell.note = notes.data[indexPath.item]
                }
                return cell
            }
        }
        fatalError()
    }
}

// MARK: - UICollectionViewDelegate
extension DashboardViewController {
    
}
