//
//  LoadingAlertController.swift
//  NotesManager
//
//  Created by pnam on 12/08/2022.
//

@_implementationOnly import UIKit

class LoadingAlertController: UIViewController {
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    @IBOutlet weak var messageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - BaseContentAlertController
extension LoadingAlertController: BaseContentAlertController {
    
}
