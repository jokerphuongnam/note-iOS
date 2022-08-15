//
//  NoteDetailViewController+ViewDelegate.swift
//  NotesManager
//
//  Created by pnam on 06/08/2022.
//

@_implementationOnly import UIKit

// MARK: - UIScrollViewDelegate
extension NoteDetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        setNavigationBarTitle(largeTitle: viewModel.note.title ?? "", collapsedTitle: Strings.noteDetail)
    }
}
