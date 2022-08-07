//
//  ConfigHeaderView.swift
//  NotesManager
//
//  Created by pnam on 06/08/2022.
//

@_implementationOnly import UIKit

@objc protocol ConfigHeaderViewDelegate: AnyObject {
    @objc optional func configHeader(_ configHeaderView: ConfigHeaderView, addAction flag: Bool, at numberOfSection: Int, _ sender: UIButton, forEvent event: UIEvent)
}

final class ConfigHeaderView: UICollectionReusableView {
    weak var delegate: ConfigHeaderViewDelegate!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var actionButton: UIButton!
    private var addImage = UIImage(systemName: "plus")
    private var minusImage = UIImage(systemName: "minus")
    var flag: Bool = true {
        willSet {
            actionButton.setImage(newValue ? minusImage : addImage, for: .normal)
        }
    }
    var section: Int = -1
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func addAction(_ sender: UIButton, forEvent event: UIEvent) {
        if section != 2 {
            flag.toggle()
            delegate?.configHeader?(self, addAction: flag, at: section, sender, forEvent: event)
        }
    }
}
