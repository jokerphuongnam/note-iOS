//
//  ChangePasswordViewController.swift
//  NotesManager
//
//  Created by pnam on 07/08/2022.
//

@_implementationOnly import UIKit

class ChangePasswordViewController: UIViewController {
    var viewModel: ChangePasswordViewModel!

    init(viewModel: ChangePasswordViewModel) {
        super.init(nibName: String(describing: Self.self), bundle: Bundle.main)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        viewModel = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.update(
            backroundColor: Asset.Colors.background.color,
            titleColor: Asset.Colors.text.color
        )
    }
}
