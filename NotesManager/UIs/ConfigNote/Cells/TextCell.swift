//
//  TextCell.swift
//  NotesManager
//
//  Created by pnam on 06/08/2022.
//

@_implementationOnly import UIKit

@objc protocol TextCellDelegate {
    @objc optional func text(_ textCell: TextCell, didEndEditing text: String, at index: Int , sender textField: UITextField)
    @objc optional func text(_ textCell: TextCell, shouldReturn text: String, at index: Int , sender textField: UITextField)
}

final class TextCell: UICollectionViewCell {
    weak var delegate: TextCellDelegate!
    @IBOutlet weak var contentTextField: UITextField!
    var item: Int = -1
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentTextField.delegate = self
    }
}

// MARK: - UITextFieldDelegate
extension TextCell: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text {
            delegate?.text?(self, didEndEditing: text, at: item, sender: textField)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        contentTextField.resignFirstResponder()
        if let text = textField.text {
            delegate?.text?(self, shouldReturn: text, at: item, sender: textField)
        }
        return true
    }
}
