//
//  View+.swift
//  NotesManager
//
//  Created by pnam on 02/08/2022.
//

import UIKit

// MARK: - property IBInspectable
extension UIView {
    @IBInspectable var isCircle: Bool {
        get {
            layer.masksToBounds && layer.cornerRadius == frame.height / 2.0
        }
        set {
            if newValue {
                layer.cornerRadius = (frame.width < frame.height ? frame.width : frame.height) / 2.0
                layer.masksToBounds = newValue
            }
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var maskedCorners: CACornerMask {
        get {
            layer.maskedCorners
        }
        set {
            layer.maskedCorners = newValue
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    func roundCorners(_ radius: CGFloat, corners: CACornerMask) {
        layer.maskedCorners = corners
        layer.cornerRadius = 10
        clipsToBounds = true
    }
}

extension UIImage {
    func withPadding(_ padding: CGFloat) -> UIImage? {
        withPadding(x: padding, y: padding)
    }
    
    func withPadding(x: CGFloat, y: CGFloat) -> UIImage? {
        let newWidth = size.width + 2 * x
        let newHeight = size.height + 2 * y
        let newSize = CGSize(width: newWidth, height: newHeight)
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0)
        let origin = CGPoint(x: (newWidth - size.width) / 2, y: (newHeight - size.height) / 2)
        draw(at: origin)
        let imageWithPadding = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return imageWithPadding
    }
}

extension UITextField {
    @IBInspectable var leftPaddingPoints: CGFloat {
        get {
            rightView?.frame.width ?? 0.0
        }
        set {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: frame.size.height))
            leftView = paddingView
            leftViewMode = .always
        }
    }
    
    @IBInspectable var rightPaddingPoints: CGFloat {
        get {
            rightView?.frame.width ?? 0.0
        }
        set {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: frame.size.height))
            rightView = paddingView
            rightViewMode = .always
        }
    }
}

extension UITextView {
    private class PlaceholderLabel: UILabel {
        
    }

    private var placeholderLabel: PlaceholderLabel {
        if let label = subviews.compactMap({ $0 as? PlaceholderLabel }) .first {
            return label
        } else {
            let label = PlaceholderLabel(frame: .zero)
            label.font = font
            label.textColor = .opaqueSeparator
            addSubview(label)
            return label
        }
    }

    @IBInspectable
    var placeholder: String {
        get {
            return subviews.compactMap( { $0 as? PlaceholderLabel }).first?.text ?? ""
        }
        set {
            let placeholderLabel = placeholderLabel
            placeholderLabel.text = newValue
            placeholderLabel.numberOfLines = 0
            let width = frame.width - textContainer.lineFragmentPadding * 2
            let size = placeholderLabel.sizeThatFits(CGSize(width: width, height: .greatestFiniteMagnitude))
            placeholderLabel.frame.size.height = size.height
            placeholderLabel.frame.size.width = width
            placeholderLabel.frame.origin = CGPoint(x: textContainer.lineFragmentPadding, y: textContainerInset.top)

            textStorage.delegate = self
        }
    }
}

extension UITextView: NSTextStorageDelegate {
    public func textStorage(_ textStorage: NSTextStorage, didProcessEditing editedMask: NSTextStorage.EditActions, range editedRange: NSRange, changeInLength delta: Int) {
        if editedMask.contains(.editedCharacters) {
            placeholderLabel.isHidden = !text.isEmpty
        }
    }
}
