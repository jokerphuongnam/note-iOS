//
//  DashboardViewController+ViewDelegate.swift
//  NotesManager
//
//  Created by pnam on 05/08/2022.
//

@_implementationOnly import UIKit

// MARK: - UISearchResultsUpdating
extension DashboardViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchWords = searchController.searchBar.text else { return }
        viewModel.reloadNotes(searchWords: searchWords)
    }
}

// MARK: - UISearchControllerDelegate
extension DashboardViewController: UISearchControllerDelegate {
    
}

// MARK: - NoteDetailViewControllerDelegate
extension DashboardViewController: NoteDetailViewControllerDelegate {
    func noteDetailViewController(_ noteDetailViewController: NoteDetailViewController, updateNote note: Note) {
        guard var notes = self.viewModel.notes else { return }
        for index in 0..<notes.data.count {
            if notes.data[index].id.lowercased() == note.id.lowercased() {
                notes.data[index] = note
                viewModel.notesObserver.accept(
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
    
    func noteDetailViewController(_ noteDetailViewController: NoteDetailViewController, deleteNote id: String) {
        viewModel.reloadNotes(searchWords: nil)
    }
}
