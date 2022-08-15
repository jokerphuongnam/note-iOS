//
//  ConfigNoteViewController+CollectionView.swift
//  NotesManager
//
//  Created by pnam on 06/08/2022.
//

@_implementationOnly import UIKit

// MARK: - layout
extension ConfigNoteViewController {
    var layout: UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { [weak self] (numberOfSection, env) in
            guard self != nil else {
                return nil
            }
            let item = NSCollectionLayoutItem(
                layoutSize: .init(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1)
                )
            )
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: .init(
                    widthDimension: .absolute(50),
                    heightDimension: .absolute(50)
                ),
                subitems: [item]
            )
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 8
            section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
            section.contentInsets.leading = 8
            section.contentInsets.trailing = 8
            return section
        }
    }
}

// MARK: - UICollectionViewDataSource
extension ConfigNoteViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        optionColors.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if optionColors.count == indexPath.item {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ConfigNoteViewController.paletteColorCellName, for: indexPath) as? PaletteColorCell {
                return cell
            }
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ConfigNoteViewController.elementColorName, for: indexPath)
            cell.backgroundColor = optionColors[indexPath.item]
            cell.borderWidth = 1
            cell.borderColor = Asset.Colors.text.color
            cell.isCircle = true
            return cell
        }
        fatalError()
    }
}

// MARK: - UICollectionViewDelegate
extension ConfigNoteViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == optionColors.count {
            let colorPickerViewController = UIColorPickerViewController()
            colorPickerViewController.delegate = self
            colorPickerViewController.selectedColor = selectedPaletteColor
            present(colorPickerViewController, animated: true)
        } else {
            let selectedColor = optionColors[indexPath.item]
            viewModel.note.color = selectedColor
            colorReviewView.backgroundColor = selectedColor
        }
    }
}
