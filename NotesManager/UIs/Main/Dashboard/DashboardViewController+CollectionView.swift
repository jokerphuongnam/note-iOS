//
//  DashboardViewController+CollectionView.swift
//  NotesManager
//
//  Created by pnam on 04/08/2022.
//

@_implementationOnly import UIKit

// MARK: UICollectionViewDataSource
extension DashboardViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.notes?.data.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Self.noteCellName, for: indexPath) as? NoteCell {
            cell.backgroundColor = indexPath.item % 2 == 0 ? .blue : .green
            return cell
        }
        fatalError()
    }
}

// MARK: UICollectionViewDelegate
extension DashboardViewController {
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        setNavigationBarTitle(largeTitle: "Large Dashboard", collapsedTitle: "Collapsed Dashboard")
    }
}
