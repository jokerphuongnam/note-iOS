//
//  EditProfileViewController.swift
//  NotesManager
//
//  Created by pnam on 07/08/2022.
//

@_implementationOnly import UIKit
@_implementationOnly import RxSwift

final class EditProfileViewController: UIViewController {
    var viewModel: EditProfileViewModel!
    private var keyboardManager: KeyboardManagerment!
    let disposeBag: DisposeBag = DisposeBag()
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet var genderButtons: [UIButton]!
    
    init(viewModel: EditProfileViewModel) {
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
        keyboardManager = .init(viewController: self, scrollView: scrollView, textField: nameTextField)
        navigationController?.navigationBar.update(
            backroundColor: Asset.Colors.background.color,
            titleColor: Asset.Colors.text.color
        )
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        keyboardManager = nil
    }
    
    private func setupView() {
        nameTextField.delegate = self
        scrollView.delegate = self
        if let user = viewModel.user {
            nameTextField.text = user.name
            configGenderButton(of: user.gender.index, isSelected: true)
        }
    }
    
    private func configGenderButton(of index: Int, isSelected flag: Bool) {
        let sender = genderButtons[index]
        if flag {
            switch index {
            case 0:
                configSelectedGenderButton(sender, backgroundColor: .cyan)
            case 1:
                configSelectedGenderButton(sender, backgroundColor: .systemPink)
            case 2:
                configSelectedGenderButton(sender, backgroundColor: .yellow)
            case 3:
                configSelectedGenderButton(sender, backgroundColor: .black)
            default: break
            }
        } else {
            sender.borderColor = Asset.Colors.gray.color
            sender.imageTint = Asset.Colors.gray.color
            sender.backgroundColor = .clear
            sender.borderWidth = 1
        }
    }
    
    private func configSelectedGenderButton(_ sender: UIButton, backgroundColor color: UIColor) {
        sender.imageTint = Asset.Colors.background.color
        sender.backgroundColor = color
        sender.borderWidth = 0
    }
}

// MARK: - Action
private extension EditProfileViewController {
    @IBAction func nameEditingChanged(_ sender: UITextField, forEvent event: UIEvent) {
        if let name = sender.text, sender == nameTextField {
            viewModel.user.name = name
        }
    }
    
    @IBAction private func gendersAction(_ sender: UIButton, forEvent event: UIEvent) {
        if let index = genderButtons.firstIndex(of: sender) {
            viewModel.user.gender = .init(of: index)
        }
        for index in 0..<genderButtons.count {
            configGenderButton(of: index, isSelected: index == viewModel.user.gender.index)
        }
    }
    
    @IBAction private func confirmAction(_ sender: UIButton, forEvent event: UIEvent) {
        let loadingContentViewController = LoadingAlertController()
        let loadingAlertController = loadingContentViewController.alertController
        loadingContentViewController.messageLabel.text = Strings.loading
        present(loadingAlertController, animated: true)
        viewModel.editProfile()
            .subscribe { [weak self] in
                loadingAlertController.dismiss(animated: true)
                guard let self = self else { return }
                let alertController = UIAlertController(title: Strings.editProfile, message: Strings.success, preferredStyle: .alert)
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

private extension User.Gender {
    var index: Int {
        switch self {
        case .male:
            return 0
        case .female:
            return 1
        case .other:
            return 2
        case .secret:
            return 3
        }
    }
    
    init(of index: Int) {
        switch index {
        case 0:
            self = .male
        case 1:
            self = .female
        case 2:
            self = .other
        case 3:
            self = .secret
        default:
            fatalError()
        }
    }
}
