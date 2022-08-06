//
//  NoteDetailViewController+NavigationBar.swift
//  NotesManager
//
//  Created by pnam on 06/08/2022.
//

import Foundation

extension NoteDetailViewController {
    func setupNavigationBar() {
        title = viewModel.note.title
        navigationController?.navigationBar.update(
            backroundColor: Asset.Colors.background.color,
            titleColor: Asset.Colors.text.color
        )
        navigationItem.rightBarButtonItems = [deleteNoteButton, editNoteButton]
    }
}
