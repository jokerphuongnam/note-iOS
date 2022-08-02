//
//  NavigationBar+.swift
//  MoveX
//
//  Created by pnam on 11/07/2022.
//

@_implementationOnly import UIKit

extension UINavigationBar {
    func update(backroundColor: UIColor? = nil, titleColor: UIColor? = nil) {
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            if let backroundColor = backroundColor {
                appearance.backgroundColor = backroundColor
            }
            if let titleColor = titleColor {
                appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: titleColor]
            }
            standardAppearance = appearance
            scrollEdgeAppearance = appearance
        } else {
            if let backroundColor = backroundColor {
                barTintColor = backroundColor
            }
            if let titleColor = titleColor {
                titleTextAttributes = [NSAttributedString.Key.foregroundColor: titleColor]
            }
        }
    }
    
    func removeBottomShadow() {
        setBackgroundImage(UIImage(), for: .default)
        shadowImage = UIImage()
    }
}
