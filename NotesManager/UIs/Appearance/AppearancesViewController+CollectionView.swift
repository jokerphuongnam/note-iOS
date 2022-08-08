//
//  AppearancesViewController+CollectionView.swift
//  NotesManager
//
//  Created by pnam on 08/08/2022.
//

@_implementationOnly import UIKit

// MARK: - layout
extension AppearancesViewController {
    var flowLayout: UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = .init(width: collectionView.frame.width - 32, height: 200)
        layout.sectionInset = .init(top: 0, left: 16, bottom: 0, right: 16)
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 16
        return layout
    }
}

// MARK: - UICollectionViewDataSource
extension AppearancesViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        appearances.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let appearance = appearances[indexPath.item]
        if indexPath.item < appearances.count - 1 {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Self.simpleAppearanceCellName, for: indexPath) as? SimpleAppearanceCell {
                cell.titleLabel.text = appearance.mode
                cell.checkImageView.isHidden = viewModel.appearance != appearance
                return cell
            }
        } else {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Self.customAppearanceCellName, for: indexPath) as? CustomAppearanceCell {
                if case .custom(startDarkMode: let startTime, endDarkMode: let endTime) = appearance {
                    if viewModel.appearance == appearance {
                        cell.setSelected(startTime: startTime, endTime: endTime)
                    } else {
                        cell.unSelected()
                    }
                    
                }
                return cell
            }
        }
        fatalError()
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension AppearancesViewController: UICollectionViewDelegateFlowLayout {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.appearance = appearances[indexPath.item]
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width - 32
        if indexPath.item < appearances.count - 1 {
            return .init(width: width, height: 50)
        } else {
            if viewModel.appearance == appearances[indexPath.item] {
                return .init(width: width, height: 200)
            } else {
                return .init(width: width, height: 50)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        16
    }
}
