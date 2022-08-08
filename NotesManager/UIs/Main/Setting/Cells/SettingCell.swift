//
//  SettingCell.swift
//  NotesManager
//
//  Created by pnam on 05/08/2022.
//

@_implementationOnly import UIKit

final class SettingCell: UICollectionViewCell {
    var option: SettingOption! {
        willSet {
            guard let newValue = newValue else {
                return
            }
            iconImage.image = newValue.settingIcon
            titleLabel.text = newValue.title
            valueLabel.isHidden = newValue.isHiddenValueLabel
            valueLabel.text = newValue.settingValue?.name
        }
    }
    
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var nextImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
