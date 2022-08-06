//
//  NoteDetailViewController+NavigationBar.swift
//  NotesManager
//
//  Created by pnam on 06/08/2022.
//

import Foundation

extension NoteDetailViewController {
    func setupNavigationBar() {
        if let noteTitle = viewModel.note.title {
            setNavigationBarTitle(largeTitle: noteTitle, collapsedTitle: Strings.noteDetail)
            navigationController?.navigationBar.prefersLargeTitles = true
        } else {
            setNavigationBarTitle(largeTitle: "", collapsedTitle: Strings.noteDetail)
            navigationController?.navigationBar.prefersLargeTitles = false
        }
        navigationController?.navigationBar.update(
            backroundColor: Asset.Colors.background.color,
            titleColor: Asset.Colors.text.color
        )
        navigationItem.rightBarButtonItems = [deleteNoteButton, editNoteButton]
    }
}
