//
//  RegisterViewController.swift
//  NotesManager
//
//  Created by pnam on 02/08/2022.
//

@_implementationOnly import UIKit

class RegisterViewController: UIViewController {
    private var keyboardManager: KeyboardManagerment!
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        resumeNavigationBar()
        keyboardManager = .init(viewController: self, scrollView: scrollView, textField: emailTextField, passwordTextField, repeatPasswordTextField)
        emailTextField.delegate = self
        passwordTextField.delegate = self
        repeatPasswordTextField.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        keyboardManager = nil
    }
    
    private func setupView() {
        
    }
    
    @IBAction func registerAction(_ sender: UIButton, forEvent event: UIEvent) {
        
    }
}
