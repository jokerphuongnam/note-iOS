//
//  ConfigNoteViewController+ViewDelegate.swift
//  NotesManager
//
//  Created by pnam on 06/08/2022.
//

@_implementationOnly import UIKit

// MARK: - UIColorPickerViewControllerDelegate
extension ConfigNoteViewController: UIColorPickerViewControllerDelegate {
    func colorPickerViewController(_ viewController: UIColorPickerViewController, didSelect color: UIColor, continuously: Bool) {
        selectedPaletteColor = color
    }
    
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        viewModel.note.color = selectedPaletteColor
        colorReviewView.backgroundColor = selectedPaletteColor
    }
}

// MARK: - UITextFieldDelegate
extension ConfigNoteViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case titleTextField:
            textField.placeholder = "\(Strings.titlePlaceholder)..."
        default: break
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.placeholder = "Aa"
    }
}

extension ConfigNoteViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        let fixedWidth = textView.frame.size.width - textView.contentInset.left - textView.contentInset.right
        textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        let newSize = textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        var newFrame = textView.frame
        newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
        if titleTextField.frame.height * 5 > newFrame.height {
            descriptionTextViewContraintHeight.constant = newFrame.height
            UIView.animate(withDuration: Self.timeAnimation) { [weak self] in
                guard let self = self else { return }
                self.view.layoutIfNeeded()
            }
        }
        
        viewModel.note.description = textView.text
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        switch textView {
        case descriptionTextView:
            textView.placeholder = "\(Strings.descriptionPlaceholder)..."
        default: break
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.placeholder = "Aa"
    }
}
