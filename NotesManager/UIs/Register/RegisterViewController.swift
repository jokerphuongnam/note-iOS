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
    
    private lazy var emailButton: UIButton = { [weak self] in
        let emailImage = UIButton(frame: .init(x: 0, y: 0, width: passwordTextField.frame.height, height: passwordTextField.frame.height))
        let image = Asset.Assets.email.image
        emailImage.setImage(image, for: .normal)
        emailImage.addTarget(self, action: #selector(showHideButtonAction), for: .touchUpInside)
        emailImage.contentEdgeInsets = .init(top: 0, left: 16, bottom: 0, right: 16)
        emailImage.imageView?.layer.magnificationFilter = CALayerContentsFilter.nearest
        return emailImage
    }()
    
    private lazy var passwordButton: UIButton = { [weak self] in
        let emailImage = UIButton(frame: .init(x: 0, y: 0, width: passwordTextField.frame.height, height: passwordTextField.frame.height))
        let image = Asset.Assets.password.image
        emailImage.setImage(image, for: .normal)
        emailImage.contentEdgeInsets = .init(top: 0, left: 16, bottom: 0, right: 16)
        emailImage.imageView?.layer.magnificationFilter = CALayerContentsFilter.nearest
        return emailImage
    }()
    
    private lazy var showHidePasswordButton: UIButton = { [weak self] in
        let showHideButton = UIButton(frame: .init(x: 0, y: 0, width: passwordTextField.frame.height, height: passwordTextField.frame.height))
        let image = (!passwordTextField.isSecureTextEntry ? Asset.Assets.hideEye : Asset.Assets.eye).image
        showHideButton.setImage(image, for: .normal)
        showHideButton.addTarget(self, action: #selector(showHideButtonAction), for: .touchUpInside)
        showHideButton.contentEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 16)
        showHideButton.imageView?.layer.magnificationFilter = CALayerContentsFilter.nearest
        return showHideButton
    }()
    
    private lazy var repeatPasswordButton: UIButton = { [weak self] in
        let emailImage = UIButton(frame: .init(x: 0, y: 0, width: passwordTextField.frame.height, height: passwordTextField.frame.height))
        let image = Asset.Assets.password.image
        emailImage.setImage(image, for: .normal)
        emailImage.contentEdgeInsets = .init(top: 0, left: 16, bottom: 0, right: 16)
        emailImage.imageView?.layer.magnificationFilter = CALayerContentsFilter.nearest
        return emailImage
    }()
    
    private lazy var showHideRepeatPasswordButton: UIButton = { [weak self] in
        let showHideButton = UIButton(frame: .init(x: 0, y: 0, width: passwordTextField.frame.height, height: passwordTextField.frame.height))
        let image = (!passwordTextField.isSecureTextEntry ? Asset.Assets.hideEye : Asset.Assets.eye).image
        showHideButton.setImage(image, for: .normal)
        showHideButton.addTarget(self, action: #selector(showHideButtonAction), for: .touchUpInside)
        showHideButton.contentEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 16)
        showHideButton.imageView?.layer.magnificationFilter = CALayerContentsFilter.nearest
        return showHideButton
    }()
    
#if DEBUG
    deinit {
        print("Deinit: \(String(describing: Self.self))")
    }
#endif
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        keyboardManager = .init(viewController: self, scrollView: scrollView, textField: emailTextField, passwordTextField, repeatPasswordTextField)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        keyboardManager = nil
    }
    
    private func setupView() {
        emailTextField.becomeFirstResponder()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        repeatPasswordTextField.delegate = self
        emailTextField.leftView = emailButton
        emailTextField.leftViewMode = .always
        passwordTextField.leftView = passwordButton
        passwordTextField.leftViewMode = .always
        passwordTextField.rightView = showHidePasswordButton
        passwordTextField.rightViewMode = .always
        repeatPasswordTextField.leftView = repeatPasswordButton
        repeatPasswordTextField.leftViewMode = .always
        repeatPasswordTextField.rightView = showHideRepeatPasswordButton
        repeatPasswordTextField.rightViewMode = .always
    }
}

//MARK: - Action
extension RegisterViewController {
    @objc private func showHideButtonAction(_ sender: UIButton, forEvent event: UIEvent) {
        let passwordTextField: UITextField = sender == showHidePasswordButton ? passwordTextField : repeatPasswordTextField
        let image = (passwordTextField.isSecureTextEntry ? Asset.Assets.hideEye : Asset.Assets.eye).image
        sender.setImage(image, for: .normal)
        passwordTextField.isSecureTextEntry.toggle()
    }
    
    @IBAction func registerAction(_ sender: UIButton, forEvent event: UIEvent) {
        
    }
}
