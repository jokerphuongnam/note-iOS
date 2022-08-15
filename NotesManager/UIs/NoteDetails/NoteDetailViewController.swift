//
//  NoteDetailViewController.swift
//  NotesManager
//
//  Created by pnam on 06/08/2022.
//

@_implementationOnly import UIKit
@_implementationOnly import RxSwift

protocol NoteDetailViewControllerDelegate: AnyObject {
    func noteDetailViewController(_ noteDetailViewController :NoteDetailViewController, updateNote note: Note)
    func noteDetailViewController(_ noteDetailViewController :NoteDetailViewController, deleteNote id: String)
}

final class NoteDetailViewController: UIViewController {
    var viewModel: NoteDetailViewModel!
    weak var delegate: NoteDetailViewControllerDelegate!
    let disposeBag: DisposeBag = DisposeBag()
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    lazy var editNoteButton: UIBarButtonItem = { [weak self] in
            let buttonView = UIButton()
            buttonView.hero.isEnabled = true
            buttonView.heroID = "note"
            buttonView.setImage(UIImage(systemName: "pencil"), for: .normal)
            if let self = self {
                buttonView.addTarget(self, action: #selector(editNoteAction), for: .touchUpInside)
            } else {
                buttonView.addTarget(nil, action: #selector(editNoteAction), for: .touchUpInside)
            }
            return UIBarButtonItem(customView: buttonView)
    }()
    
    lazy var deleteNoteButton: UIBarButtonItem = { [weak self] in
        let buttonView = UIButton()
        buttonView.hero.isEnabled = true
        buttonView.heroID = "note"
        buttonView.setImage(UIImage(systemName: "trash"), for: .normal)
        if let self = self {
            buttonView.addTarget(self, action: #selector(deleteNoteAction), for: .touchUpInside)
        } else {
            buttonView.addTarget(nil, action: #selector(deleteNoteAction), for: .touchUpInside)
        }
        return UIBarButtonItem(customView: buttonView)
    }()
    
    init(viewModel: NoteDetailViewModel) {
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
        setupLiveData()
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.update(
            backroundColor: Asset.Colors.background.color,
            titleColor: Asset.Colors.text.color
        )
    }
    
    private func setupView() {
        hero.modalAnimationType = .zoom
        view.backgroundColor = viewModel.note.color
    }
    
    private func setupLiveData() {
        viewModel.noteObserver
            .subscribe(on: MainScheduler.instance)
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] note in
                guard let self = self else { return }
                let note = self.viewModel.note
                self.title = note.title
                self.descriptionLabel.text = note.description
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd/MM/yyyy hh:mm"
                let createAt = dateFormatter.string(from: Date(milliseconds: note.createAt))
                let updateAt = dateFormatter.string(from: Date(milliseconds: note.updateAt))
                self.timeLabel.text = "\(createAt) - \(updateAt)"
            } onError: { e in
                
            } onCompleted: {
                
            } onDisposed: {
                
            }
            .disposed(by: disposeBag)
    }
}

// MARK: - Action
private extension NoteDetailViewController {
    @objc func editNoteAction(_ sender: UIBarButtonItem) {
        let viewModel: ConfigNoteViewModel = ConfigNoteViewModelImpl(useCase: NoteManagerAssembler.inject(), note: viewModel.note)
        let viewController = ConfigNoteViewController(viewModel: viewModel)
        viewController.completion = { [weak self] note in
            guard let self = self else { return }
            self.viewModel.noteObserver.accept(note)
            self.delegate?.noteDetailViewController(self, updateNote: note)
        }
        let navigation = UINavigationController(rootViewController: viewController)
        present(navigation, animated: true)
    }
    
    @objc func deleteNoteAction(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: Strings.delete, message: Strings.deleteDescription, preferredStyle: .alert)
        
        let okAlertAction = UIAlertAction(title: Strings.ok, style: .default) { [weak self] action in
            guard let self = self else { return }
            let loadingContentViewController = LoadingAlertController()
            let loadingAlertController = loadingContentViewController.alertController
            loadingContentViewController.messageLabel.text = Strings.loading
            self.present(loadingAlertController, animated: true)
            self.viewModel.deleteNote()
                .subscribe { [weak self] in
                    loadingAlertController.dismiss(animated: true)
                    guard let self = self else { return }
                    self.delegate?.noteDetailViewController(self, deleteNote: self.viewModel.note.id)
                    let alertController = UIAlertController(title: Strings.delete, message: Strings.success, preferredStyle: .alert)
                    let okAction = UIAlertAction(title: Strings.ok, style: .default) { [weak self] action in
                        guard let self = self else { return }
                        self.navigationController?.popViewController(animated: true)
                    }
                    okAction.titleTextColor = Asset.Colors.main.color
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true)
                } onError: { error in
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
                .disposed(by: self.disposeBag)
        }
        okAlertAction.titleTextColor = Asset.Colors.main.color
        alertController.addAction(okAlertAction)
        
        let cancelAction = UIAlertAction(title: Strings.cancel, style: .cancel, handler: nil)
        cancelAction.titleTextColor = Asset.Colors.red.color
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true)
    }
}
