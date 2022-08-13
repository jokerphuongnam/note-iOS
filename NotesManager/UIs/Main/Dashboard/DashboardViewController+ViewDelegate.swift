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
