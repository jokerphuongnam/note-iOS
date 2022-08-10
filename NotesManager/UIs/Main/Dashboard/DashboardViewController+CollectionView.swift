//
//  DashboardViewController+CollectionView.swift
//  NotesManager
//
//  Created by pnam on 04/08/2022.
//

@_implementationOnly import UIKit

// MARK: - layout
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
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let note = viewModel.notes?.data[indexPath.item] else { return }
        let viewModel: NoteDetailViewModel = NoteDetailViewModelImpl(note: note)
        let viewController = NoteDetailViewController(viewModel: viewModel)
        viewController.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        switch loadingType {
        case .reload:
            self.viewModel.reloadNotes()
        case .loadMore:
            self.viewModel.loadMoreNotes()
        default: break
        }
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let notes = viewModel.notes, notes.hasNext {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                scrollView.defaultLoadingView(isLoading: &self.viewModel.isLoading, reloadTitle: Strings.pullToReload, loadMoreTitle: Strings.pullToLoadMore) { [weak self] type in
                    guard let self = self else { return }
                    self.loadingType = type
                    switch type {
                    case .reload:
                        break
                    case .loadMore:
                        break
                    }
                }
            }
        }
    }
}
