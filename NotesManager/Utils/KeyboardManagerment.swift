//
//  MoveTextField.swift
//  MoveX
//
//  Created by pnam on 17/07/2022.
//

@_implementationOnly import UIKit

#if targetEnvironment(simulator)
#else
final class KeyboardManagerment {
    private typealias TextFields = [UITextField]
    private var textFields: TextFields
    private weak var scrollView: UIScrollView!
    private weak var viewController: UIViewController!
    
    init(viewController: UIViewController ,scrollView: UIScrollView, textField: UITextField...) {
        self.scrollView = scrollView
        self.textFields = textField
        self.viewController = viewController
        
        if !textField.isEmpty {
            NotificationCenter.default.addObserver(viewController, selector: #selector(onKeyboardAppear(_:)), name: UIResponder.keyboardDidShowNotification, object: nil)
            NotificationCenter.default.addObserver(viewController, selector: #selector(onKeyboardDisappear(_:)), name: UIResponder.keyboardDidHideNotification, object: nil)
        }
    }
    
    
    deinit {
        if !textFields.isEmpty {
            NotificationCenter.default.removeObserver(viewController ?? self, name: UIResponder.keyboardDidShowNotification, object: nil)
            NotificationCenter.default.removeObserver(viewController ?? self, name: UIResponder.keyboardDidHideNotification, object: nil)
            textFields.removeAll()
        }
        scrollView = nil
        viewController = nil
    }
    
    @objc private func onKeyboardAppear(_ notification: NSNotification) {
        let info = notification.userInfo!
        let rect: CGRect = info[UIResponder.keyboardFrameBeginUserInfoKey] as! CGRect
        let kbSize = rect.size
        
        let insets = UIEdgeInsets(top: 0, left: 0, bottom: kbSize.height, right: 0)
        scrollView.contentInset = insets
        scrollView.scrollIndicatorInsets = insets
        
        // If active text field is hidden by keyboard, scroll it so it's visible
        // Your application might not need or want this behavior.
        var aRect = viewController.view.frame;
        aRect.size.height -= kbSize.height;
        
        let activeField: UITextField? = textFields.first { $0.isFirstResponder }
        if let activeField = activeField {
            if !aRect.contains(activeField.frame.origin) {
                let scrollPoint = CGPoint(x: 0, y: activeField.frame.origin.y-kbSize.height)
                scrollView.setContentOffset(scrollPoint, animated: true)
            }
        }
    }
    
    @objc private func onKeyboardDisappear(_ notification: NSNotification) {
        scrollView.contentInset = UIEdgeInsets.zero
        scrollView.scrollIndicatorInsets = UIEdgeInsets.zero
    }
}
#endif
