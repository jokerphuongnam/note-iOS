//
//  LoginViewController.swift
//  NotesManager
//
//  Created by pnam on 02/08/2022.
//

@_implementationOnly import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
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
    
    @IBAction func registerAction(_ sender: UIButton, forEvent event: UIEvent) {
        let registerViewController = RegisterViewController()
        navigationController?.pushViewController(registerViewController, animated: true)
    }
    
    @IBAction func loginAction(_ sender: UIButton, forEvent event: UIEvent) {
    }
}
