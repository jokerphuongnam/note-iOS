//
//  KeyWindow+.swift
//  NotesManager
//
//  Created by pnam on 03/08/2022.
//

@_implementationOnly import UIKit

extension UIWindow {
    static var key: UIWindow? {
        if #available(iOS 13, *) {
            return UIApplication.shared.windows.first { $0.isKeyWindow }
        } else {
            return UIApplication.shared.keyWindow
        }
    }
}
