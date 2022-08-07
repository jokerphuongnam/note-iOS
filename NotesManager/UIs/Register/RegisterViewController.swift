//
//  RegisterViewController.swift
//  NotesManager
//
//  Created by pnam on 02/08/2022.
//

@_implementationOnly import UIKit

final class RegisterViewController: UIViewController {
    private var keyboardManager: KeyboardManagerment!
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    
    private lazy var emailButton: UIButton = { [weak self] in
        let emailButton = UIButton(frame: .init(x: 0, y: 0, width: passwordTextField.frame.height, height: passwordTextField.frame.height))
        let image = Asset.Assets.email.image
        emailButton.setImage(image, for: .normal)
        emailButton.imageTint = Asset.Colors.text.color
        emailButton.addTarget(self, action: #selector(showHideButtonAction), for: .touchUpInside)
        emailButton.contentEdgeInsets = .init(top: 0, left: 16, bottom: 0, right: 16)
        emailButton.imageView?.layer.magnificationFilter = CALayerContentsFilter.nearest
        return emailButton
    }()
    
    private lazy var passwordButton: UIButton = { [weak self] in
        let passwordButton = UIButton(frame: .init(x: 0, y: 0, width: passwordTextField.frame.height, height: passwordTextField.frame.height))
        let image = Asset.Assets.password.image
        passwordButton.setImage(image, for: .normal)
        passwordButton.imageTint = Asset.Colors.text.color
        passwordButton.contentEdgeInsets = .init(top: 0, left: 16, bottom: 0, right: 16)
        passwordButton.imageView?.layer.magnificationFilter = CALayerContentsFilter.nearest
        return passwordButton
    }()
    
    private lazy var showHidePasswordButton: UIButton = { [weak self] in
        let showHideButton = UIButton(frame: .init(x: 0, y: 0, width: passwordTextField.frame.height, height: passwordTextField.frame.height))
        let image = (!passwordTextField.isSecureTextEntry ? Asset.Assets.hideEye : Asset.Assets.eye).image
        showHideButton.setImage(image, for: .normal)
        showHideButton.imageTint = Asset.Colors.text.color
        showHideButton.addTarget(self, action: #selector(showHideButtonAction), for: .touchUpInside)
        showHideButton.contentEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 16)
        showHideButton.imageView?.layer.magnificationFilter = CALayerContentsFilter.nearest
        return showHideButton
    }()
    
    private lazy var repeatPasswordButton: UIButton = { [weak self] in
        let showHideButton = UIButton(frame: .init(x: 0, y: 0, width: passwordTextField.frame.height, height: passwordTextField.frame.height))
        let image = Asset.Assets.password.image
        showHideButton.setImage(image, for: .normal)
        showHideButton.imageTint = Asset.Colors.text.color
        showHideButton.contentEdgeInsets = .init(top: 0, left: 16, bottom: 0, right: 16)
        showHideButton.imageView?.layer.magnificationFilter = CALayerContentsFilter.nearest
        return         showHideButton
    }()
    
    private lazy var showHideRepeatPasswordButton: UIButton = { [weak self] in
        let showHideButton = UIButton(frame: .init(x: 0, y: 0, width: passwordTextField.frame.height, height: passwordTextField.frame.height))
        let image = (!passwordTextField.isSecureTextEntry ? Asset.Assets.hideEye : Asset.Assets.eye).image
        showHideButton.setImage(image, for: .normal)
        showHideButton.imageTint = Asset.Colors.text.color
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
        navigationController?.navigationBar.update(backroundColor: Asset.Colors.background.color)
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

// MARK: - Action
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
