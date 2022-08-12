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
    
    func changeRootViewControllerPresent(rootViewController viewController: UIViewController) {
        if let navView = viewController.view {
            addSubview(viewController.view)
            let naviFrame = frame
            navView.frame = .init(x: naviFrame.minX, y: naviFrame.height, width: naviFrame.width, height: naviFrame.height)
            UIView.transition(
                with: self,
                duration: 0.4,
                options: .curveEaseInOut) { [weak self] in
                    guard let self = self else { return }
                    let vcFrame = navView.frame
                    viewController.view.frame = .init(x: vcFrame.minX, y: 0, width: vcFrame.width, height: vcFrame.height)
                } completion: { [weak self] isFinished in
                    guard let self = self else { return }
                    self.rootViewController = viewController
                }
        }
    }
}
