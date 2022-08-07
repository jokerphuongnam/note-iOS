//
//  ConfigNoteViewController+ViewDelegate.swift
//  NotesManager
//
//  Created by pnam on 06/08/2022.
//

@_implementationOnly import UIKit

//MARK: - UIColorPickerViewControllerDelegate
extension ConfigNoteViewController: UIColorPickerViewControllerDelegate {
    func colorPickerViewController(_ viewController: UIColorPickerViewController, didSelect color: UIColor, continuously: Bool) {
        selectedPaletteColor = color
    }
    
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        viewModel.note.color = selectedPaletteColor
        collectionView.reloadData()
    }
}
