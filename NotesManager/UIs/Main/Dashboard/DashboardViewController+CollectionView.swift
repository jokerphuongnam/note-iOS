//
//  DashboardViewController+CollectionView.swift
//  NotesManager
//
//  Created by pnam on 04/08/2022.
//

@_implementationOnly import UIKit

// MARK: - layout
extension DashboardViewController {
    static let background = "background"
    
    var layout: UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { [weak self] (numberOfSection, env) in
            guard let self = self else {
                return nil
            }
            switch self.layoutType {
            case .vertical:
                var config = UICollectionLayoutListConfiguration(appearance: .plain)
                
                if #available(iOS 15.0, *) {
                    config.headerTopPadding = 16
                } else {
                    
                }
                config.backgroundColor = .clear
                let section = NSCollectionLayoutSection.list(using: config, layoutEnvironment: env)
                section.contentInsets.leading = 8
                section.contentInsets.trailing = 8
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
        viewController.completion = { [weak self] note in
            guard let self = self, var notes = self.viewModel.notes else { return }
            for index in 0..<notes.data.count {
                if notes.data[index].id.lowercased() == note.id.lowercased() {
                    notes.data[index] = note
                    self.viewModel.notesObserver.accept(
                        .success(
                            data: (
                                data: notes.data.sorted { lhs, rhs in
                                    lhs.updateAt < rhs.updateAt
                                },
                                hasNext: notes.hasNext,
                                hasPrev: notes.hasPrev
                            )
                        )
                    )
                    break
                }
            }
        }
        viewController.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        switch loadingType {
        case .reload:
            viewModel.reloadNotes(searchWords: nil)
        case .loadMore:
            viewModel.loadMoreNotes()
        default: break
        }
        loadingType = nil
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self, let notes = self.viewModel.notes else { return }
            if notes.hasNext {
                scrollView.defaultLoadMoreView(isLoading: &self.viewModel.isLoading, loadMoreTitle: Strings.pullToReload) { [weak self] in
                    guard let self = self else { return }
                    self.loadingType = .loadMore
                }
            }
            scrollView.defaultReloadView(isLoading: &self.viewModel.isLoading, reloadTitle: Strings.pullToReload) { [weak self] in
                guard let self = self else { return }
                self.loadingType = .reload
            }
        }
    }
}
