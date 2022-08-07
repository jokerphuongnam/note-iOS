//
//  Button+.swift
//  NotesManager
//
//  Created by pnam on 07/08/2022.
//

@_implementationOnly import UIKit

extension UIButton {
    @IBInspectable var imageTint: UIColor! {
        get {
            tintColor
        }
        set {
            let tintedImage = imageView?.image?.withRenderingMode(.alwaysTemplate)
            setImage(tintedImage, for: .normal)
            tintColor = newValue
        }
    }
}
