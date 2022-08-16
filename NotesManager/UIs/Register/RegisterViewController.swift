//
//  RegisterViewController.swift
//  NotesManager
//
//  Created by pnam on 02/08/2022.
//

@_implementationOnly import UIKit
@_implementationOnly import RxSwift

final class RegisterViewController: UIViewController {
    var viewModel: RegisterViewModel!
    private var keyboardManager: KeyboardManagerment!
    let disposeBag: DisposeBag = DisposeBag()
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
    
    init(viewModel: RegisterViewModel) {
        super.init(nibName: String(describing: Self.self), bundle: Bundle.main)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
#if DEBUG
        print("Deinit: \(String(describing: Self.self))")
#endif
        viewModel = nil
    }
    
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
private extension RegisterViewController {
    @objc private func showHideButtonAction(_ sender: UIButton, forEvent event: UIEvent) {
        let passwordTextField: UITextField = sender == showHidePasswordButton ? passwordTextField : repeatPasswordTextField
        let image = (passwordTextField.isSecureTextEntry ? Asset.Assets.hideEye : Asset.Assets.eye).image
        sender.setImage(image, for: .normal)
        passwordTextField.isSecureTextEntry.toggle()
    }
    
    @IBAction private func registerAction(_ sender: UIButton, forEvent event: UIEvent) {
        guard let email = emailTextField.text, let password = passwordTextField.text, let repeatPassword = repeatPasswordTextField.text else {
            return
        }
        
        let message: String?
        if email.count < 6 {
            message = "\(Strings.email) \(Strings.needGreatThan(6))"
        } else if !email.isValidEmail() {
            message = Strings.emailNotValid
        } else if password.count < 6 {
            message = "\(Strings.password) \(Strings.needGreatThan(6))"
        } else if password != repeatPassword {
            message = Strings.errorPasswordNotSame
        } else {
            message = nil
        }
        
        if let message = message {
            let alertController = UIAlertController(title: Strings.error, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: Strings.ok, style: .default) { [weak self] action in
                self?.dismiss(animated: true)
            }
            okAction.titleTextColor = Asset.Colors.red.color
            alertController.addAction(okAction)
            present(alertController, animated: true)
            return
        }
        
        let loadingContentViewController = LoadingAlertController()
        let loadingAlertController = loadingContentViewController.alertController
        loadingContentViewController.messageLabel.text = Strings.loading
        present(loadingAlertController, animated: true)
        viewModel.register(email: email, password: password)
            .subscribe { [weak self] in
                loadingAlertController.dismiss(animated: true)
                guard let self = self else { return }
                let alertController = UIAlertController(title: Strings.register, message: Strings.success, preferredStyle: .alert)
                let okAction = UIAlertAction(title: Strings.ok, style: .default) { [weak self] action in
                    guard let self = self else { return }
                    self.navigationController?.popViewController(animated: true)
                }
                okAction.titleTextColor = Asset.Colors.main.color
                alertController.addAction(okAction)
                self.present(alertController, animated: true)
            } onError: { [weak self] error in
                loadingAlertController.dismiss(animated: true)
                guard let self = self else { return }
                let message: String
                switch error {
                case ApiError.unknownError(let responseError):
                    message = responseError.message ?? ""
                case ApiError.otherError(let responseError):
                    message = "\(Strings.unknownError): \(responseError.statusCode ?? 0)"
                default:
                    message = error.localizedDescription
                }
                let alertController = UIAlertController(title: Strings.error, message: message, preferredStyle: .alert)
                let okAction = UIAlertAction(title: Strings.ok, style: .default) { [weak self] action in
                    self?.dismiss(animated: true)
                }
                okAction.titleTextColor = Asset.Colors.red.color
                alertController.addAction(okAction)
                self.present(alertController, animated: true)
            } onDisposed: {
                
            }
            .disposed(by: disposeBag)
    }
}
