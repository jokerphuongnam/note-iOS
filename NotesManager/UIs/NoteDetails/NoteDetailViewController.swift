//
//  NoteDetailViewController.swift
//  NotesManager
//
//  Created by pnam on 06/08/2022.
//

@_implementationOnly import UIKit
@_implementationOnly import RxSwift

final class NoteDetailViewController: UIViewController {
    var viewModel: NoteDetailViewModel!
    let disposeBag: DisposeBag = DisposeBag()
    typealias Completion = (_ note: Note) -> ()
    var completion: Completion!
    
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
        completion = nil
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
            self.completion(note)
        }
        let navigation = UINavigationController(rootViewController: viewController)
        present(navigation, animated: true)
    }
    
    @objc func deleteNoteAction(_ sender: UIBarButtonItem) {
        
    }
}
