//
//  BaseContentAlertController.swift
//  NotesManager
//
//  Created by pnam on 12/08/2022.
//

@_implementationOnly import UIKit

protocol BaseContentAlertController: AnyObject {
    
}

extension BaseContentAlertController where Self: UIViewController {
    var alertController: UIAlertController {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        alertController.setValue(self, forKey: .contentAlertViewControllerKey)
        preferredContentSize = view.bounds.size
        return alertController
    }
    
    var actionSheetController: UIAlertController {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alertController.setValue(self, forKey:.contentAlertViewControllerKey)
        preferredContentSize = view.bounds.size
        return alertController
    }
    
    func dismissWhenOutSideClick() {
        view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: nil))
    }
}
