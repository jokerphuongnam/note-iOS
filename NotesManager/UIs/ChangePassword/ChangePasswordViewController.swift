//
//  ChangePasswordViewController.swift
//  NotesManager
//
//  Created by pnam on 07/08/2022.
//

@_implementationOnly import UIKit
@_implementationOnly import RxSwift

class ChangePasswordViewController: UIViewController {
    var viewModel: ChangePasswordViewModel!
    private var keyboardManager: KeyboardManagerment!
    let disposeBag: DisposeBag = DisposeBag()
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var oldPasswordTextField: UITextField!
    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    
    private lazy var oldPasswordButton: UIButton = { [weak self] in
        let passwordButton = UIButton(frame: .init(x: 0, y: 0, width: oldPasswordTextField.frame.height, height: oldPasswordTextField.frame.height))
        let image = Asset.Assets.password.image
        passwordButton.setImage(image, for: .normal)
        passwordButton.imageTint = Asset.Colors.text.color
        passwordButton.contentEdgeInsets = .init(top: 0, left: 16, bottom: 0, right: 16)
        passwordButton.imageView?.layer.magnificationFilter = CALayerContentsFilter.nearest
        return passwordButton
    }()
    
    private lazy var showHideOldPasswordButton: UIButton = { [weak self] in
        let showHideButton = UIButton(frame: .init(x: 0, y: 0, width: oldPasswordTextField.frame.height, height: oldPasswordTextField.frame.height))
        let image = (!oldPasswordTextField.isSecureTextEntry ? Asset.Assets.hideEye : Asset.Assets.eye).image
        showHideButton.setImage(image, for: .normal)
        showHideButton.imageTint = Asset.Colors.text.color
        showHideButton.addTarget(self, action: #selector(showHideButtonAction), for: .touchUpInside)
        showHideButton.contentEdgeInsets = .init(top: 0, left: 16, bottom: 0, right: 16)
        showHideButton.imageView?.layer.magnificationFilter = CALayerContentsFilter.nearest
        return showHideButton
    }()
    
    private lazy var newPasswordButton: UIButton = { [weak self] in
        let passwordButton = UIButton(frame: .init(x: 0, y: 0, width: newPasswordTextField.frame.height, height: newPasswordTextField.frame.height))
        let image = Asset.Assets.password.image
        passwordButton.setImage(image, for: .normal)
        passwordButton.imageTint = Asset.Colors.text.color
        passwordButton.contentEdgeInsets = .init(top: 0, left: 16, bottom: 0, right: 16)
        passwordButton.imageView?.layer.magnificationFilter = CALayerContentsFilter.nearest
        return passwordButton
    }()
    
    private lazy var showHideNewPasswordButton: UIButton = { [weak self] in
        let showHideButton = UIButton(frame: .init(x: 0, y: 0, width: newPasswordTextField.frame.height, height: newPasswordTextField.frame.height))
        let image = (!newPasswordTextField.isSecureTextEntry ? Asset.Assets.hideEye : Asset.Assets.eye).image
        showHideButton.setImage(image, for: .normal)
        showHideButton.imageTint = Asset.Colors.text.color
        showHideButton.addTarget(self, action: #selector(showHideButtonAction), for: .touchUpInside)
        showHideButton.contentEdgeInsets = .init(top: 0, left: 16, bottom: 0, right: 16)
        showHideButton.imageView?.layer.magnificationFilter = CALayerContentsFilter.nearest
        return showHideButton
    }()
    
    private lazy var repeatPasswordButton: UIButton = { [weak self] in
        let passwordButton = UIButton(frame: .init(x: 0, y: 0, width: repeatPasswordTextField.frame.height, height: repeatPasswordTextField.frame.height))
        let image = Asset.Assets.password.image
        passwordButton.setImage(image, for: .normal)
        passwordButton.imageTint = Asset.Colors.text.color
        passwordButton.contentEdgeInsets = .init(top: 0, left: 16, bottom: 0, right: 16)
        passwordButton.imageView?.layer.magnificationFilter = CALayerContentsFilter.nearest
        return passwordButton
    }()
    
    private lazy var showHidePasswordRepeatButton: UIButton = { [weak self] in
        let showHideButton = UIButton(frame: .init(x: 0, y: 0, width: repeatPasswordTextField.frame.height, height: repeatPasswordTextField.frame.height))
        let image = (!repeatPasswordTextField.isSecureTextEntry ? Asset.Assets.hideEye : Asset.Assets.eye).image
        showHideButton.setImage(image, for: .normal)
        showHideButton.imageTint = Asset.Colors.text.color
        showHideButton.addTarget(self, action: #selector(showHideButtonAction), for: .touchUpInside)
        showHideButton.contentEdgeInsets = .init(top: 0, left: 16, bottom: 0, right: 16)
        showHideButton.imageView?.layer.magnificationFilter = CALayerContentsFilter.nearest
        return showHideButton
    }()
    
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
        setupView()
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.update(
            backroundColor: Asset.Colors.background.color,
            titleColor: Asset.Colors.text.color
        )
        keyboardManager = .init(viewController: self, scrollView: scrollView, textField: oldPasswordTextField, newPasswordTextField, repeatPasswordTextField)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        keyboardManager = nil
    }
    
    private func setupView() {
        oldPasswordTextField.leftView = oldPasswordButton
        oldPasswordTextField.leftViewMode = .always
        oldPasswordTextField.rightView = showHideOldPasswordButton
        oldPasswordTextField.rightViewMode = .always
        
        newPasswordTextField.leftView = newPasswordButton
        newPasswordTextField.leftViewMode = .always
        newPasswordTextField.rightView = showHideNewPasswordButton
        newPasswordTextField.rightViewMode = .always
        
        repeatPasswordTextField.leftView = repeatPasswordButton
        repeatPasswordTextField.leftViewMode = .always
        repeatPasswordTextField.rightView = showHidePasswordRepeatButton
        repeatPasswordTextField.rightViewMode = .always
    }
}

// MARK: - Action
private extension ChangePasswordViewController {
    @objc private func showHideButtonAction(_ sender: UIButton, forEvent event: UIEvent) {
        let passwordTextField: UITextField?
        switch sender {
        case showHideOldPasswordButton:
            passwordTextField = oldPasswordTextField
        case showHideNewPasswordButton:
            passwordTextField = newPasswordTextField
        case showHidePasswordRepeatButton:
            passwordTextField = repeatPasswordTextField
        default:
            passwordTextField = nil
        }
        guard let passwordTextField = passwordTextField else {
            return
        }
        let image = (passwordTextField.isSecureTextEntry ? Asset.Assets.hideEye : Asset.Assets.eye).image
        sender.setImage(image, for: .normal)
        passwordTextField.isSecureTextEntry.toggle()
    }
    
    @IBAction private func confirmAction(_ sender: UIButton, forEvent event: UIEvent) {
        guard let oldPassword = oldPasswordTextField.text, let newPassword = newPasswordTextField.text, let repeatPassword = repeatPasswordTextField.text else { return }
        guard newPassword == repeatPassword else {
            let message: String = Strings.errorPasswordNotSame
            let alertController = UIAlertController(title: Strings.error, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: Strings.ok, style: .default) { [weak self] action in
                self?.dismiss(animated: true)
            }
            okAction.titleTextColor = Asset.Colors.red.color
            alertController.addAction(okAction)
            self.present(alertController, animated: true)
            return
        }
        let loadingContentViewController = LoadingAlertController()
        let loadingAlertController = loadingContentViewController.alertController
        loadingContentViewController.messageLabel.text = Strings.loading
        present(loadingAlertController, animated: true)
        viewModel.changePassword(oldPassword: oldPassword, newPassword: newPassword)
            .subscribe { [weak self] in
                loadingAlertController.dismiss(animated: true)
                guard let self = self else { return }
                let alertController = UIAlertController(title: Strings.changePassword, message: Strings.success, preferredStyle: .alert)
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
