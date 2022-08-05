//
//  LogoutView.swift
//  NotesManager
//
//  Created by pnam on 05/08/2022.
//

@_implementationOnly import UIKit

@objc protocol LogoutViewDelegate: AnyObject {
    @objc optional func logoutView(_ logoutView: LogoutView, logout sender: UIButton, forEvent event: UIEvent)
}

class LogoutView: UICollectionReusableView {
    @IBOutlet weak var logoutButton: UIButton!
    weak var delegate: LogoutViewDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func logoutAction(_ sender: UIButton, forEvent event: UIEvent) {
        delegate?.logoutView?(self, logout: sender, forEvent: event)
    }
}
