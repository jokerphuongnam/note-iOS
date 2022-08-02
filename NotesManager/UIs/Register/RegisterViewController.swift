//
//  RegisterViewController.swift
//  NotesManager
//
//  Created by pnam on 02/08/2022.
//

@_implementationOnly import UIKit

class RegisterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        resumeNavigationBar()
    }
    
    private func setupView() {
        
    }
}
