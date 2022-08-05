//
//  NoteVerticalCell.swift
//  NotesManager
//
//  Created by pnam on 05/08/2022.
//

@_implementationOnly import UIKit

class NoteVerticalCell: UICollectionViewCell {
    var note: Note! {
        willSet {
            guard let newValue = newValue else {
                return
            }
            titleLabel.text = newValue.title
            backgroundColor = .init(hex: newValue.color)
        }
    }
    @IBOutlet private weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
