//
//  ChangePasswordViewController.swift
//  NotesManager
//
//  Created by pnam on 07/08/2022.
//

@_implementationOnly import UIKit

class ChangePasswordViewController: UIViewController {
    private var keyboardManager: KeyboardManagerment!
    var viewModel: ChangePasswordViewModel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var oldPasswordTextField: UITextField!
    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    
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
        
    }
}

// MARK: - Action
private extension ChangePasswordViewController {
    @IBAction private func confirmAction(_ sender: UIButton, forEvent event: UIEvent) {
        
    }
}
