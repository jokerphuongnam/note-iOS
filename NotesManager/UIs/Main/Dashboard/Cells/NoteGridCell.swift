//
//  NoteGridCell.swift
//  NotesManager
//
//  Created by pnam on 05/08/2022.
//

@_implementationOnly import UIKit

class NoteGridCell: UICollectionViewCell {
    var note: Note! {
        willSet {
            guard let newValue = newValue else {
                return
            }
            titleLabel.text = newValue.title
            descriptionLabel.text = newValue.description
            backgroundColor = .init(hex: newValue.color)
        }
    }
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
