//
//  ConfigNoteViewController+CollectionView.swift
//  NotesManager
//
//  Created by pnam on 06/08/2022.
//

@_implementationOnly import UIKit

//MARK: - layout
extension ConfigNoteViewController {
    var layout: UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { [weak self] (numberOfSection, env) in
            guard let self = self else {
                return nil
            }
            let section: NSCollectionLayoutSection
            switch numberOfSection {
            case 0:
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
                section = NSCollectionLayoutSection(group: group)
                section.boundarySupplementaryItems = [
                    .init(
                        layoutSize: .init(
                            widthDimension: .fractionalWidth(1),
                            heightDimension: .absolute(50)
                        ),
                        elementKind: Self.titleHeader,
                        alignment: .top
                    )
                ]
                return section
            case 1:
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
                        heightDimension: .estimated(50)
                    ),
                    subitems: [item]
                )
                section = NSCollectionLayoutSection(group: group)
                section.boundarySupplementaryItems = [
                    .init(
                        layoutSize: .init(
                            widthDimension: .fractionalWidth(1),
                            heightDimension: .absolute(50)
                        ),
                        elementKind: Self.descriptionHeader,
                        alignment: .top
                    )
                ]
                return section
            case 2:
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
                section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 8
                section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
                section.contentInsets.leading = 8
                section.contentInsets.trailing = 8
                section.boundarySupplementaryItems = [
                    .init(
                        layoutSize: .init(
                            widthDimension: .fractionalWidth(1),
                            heightDimension: .absolute(50)
                        ),
                        elementKind: Self.colorHeaderViewName,
                        alignment: .top
                    )
                ]
                return section
            default:
                return nil
            }
        }
    }
}

// MARK: - UICollectionViewDataSource
extension ConfigNoteViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        3
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return isShowTitle ? 1 : 0
        case 1:
            return isShowDescription ? 1 : 0
        case 2:
            return optionColors.count + 1
        default:
            return 0
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Self.textCellName, for: indexPath) as? TextCell {
                if cell.item == -1 {
                    cell.contentTextField.placeholder = Strings.title
                    cell.contentTextField.text = viewModel.note.title
                    cell.item = indexPath.item
                    cell.delegate = self
                }
                return cell
            }
        case 1:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Self.textCellName, for: indexPath) as? TextCell {
                if cell.item == -1 {
                    cell.contentTextField.placeholder = Strings.description
                    cell.contentTextField.text = viewModel.note.description
                    cell.item = indexPath.item
                    cell.delegate = self
                }
                return cell
            }
        case 2:
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
        default:
            break
        }
        fatalError()
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case Self.titleHeader:
            if let v = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Self.titleHeader, for: indexPath) as? ConfigHeaderView {
                if v.section == -1 {
                    let section = indexPath.section
                    v.section = section
                    v.delegate = self
                    v.titleLabel.text = Strings.title
                    v.flag = viewModel.note.title != nil
                }
                return v
            }
        case Self.descriptionHeader:
            if let v = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Self.descriptionHeader, for: indexPath) as? ConfigHeaderView {
                if v.section == -1 {
                    let section = indexPath.section
                    v.section = section
                    v.delegate = self
                    v.titleLabel.text = Strings.description
                    v.flag = viewModel.note.description != nil
                }
                return v
            }
        case Self.colorHeaderViewName:
            if let v = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Self.colorHeaderViewName, for: indexPath) as? ColorHeaderView {
                v.colorView.backgroundColor = viewModel.note.color
                return v
            }
        default:
            break
        }
        fatalError()
    }
}

// MARK: - UICollectionViewDelegate
extension ConfigNoteViewController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 2 {
            if indexPath.item == optionColors.count {
                let colorPickerViewController = UIColorPickerViewController()
                colorPickerViewController.delegate = self
                colorPickerViewController.selectedColor = selectedPaletteColor
                present(colorPickerViewController, animated: true) { [weak self] in
                    
                }
            } else {
                viewModel.note.color = optionColors[indexPath.item]
                collectionView.reloadData()
            }
        }
    }
}

// MARK: - ConfigHeaderViewDelegate
extension ConfigNoteViewController: ConfigHeaderViewDelegate {
    func configHeader(_ configHeaderView: ConfigHeaderView, addAction flag: Bool, at numberOfSection: Int, _ sender: UIButton, forEvent event: UIEvent) {
        switch numberOfSection {
        case 0:
            isShowTitle = flag
            collectionView.reloadData()
        case 1:
            isShowDescription = flag
            collectionView.reloadData()
        case 2: break
        default: break
        }
    }
}

// MARK: - TextCellDelegate
extension ConfigNoteViewController: TextCellDelegate {
    func text(_ textCell: TextCell, didEndEditing text: String, at index: Int, sender textField: UITextField) {
        switch index {
        case 0:
            viewModel.note.title = text
        case 1:
            viewModel.note.description = text
        default:
            break
        }
    }
    
    func text(_ textCell: TextCell, shouldReturn text: String, at index: Int, sender textField: UITextField) {
        
    }
}
