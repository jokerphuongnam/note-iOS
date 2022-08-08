//
//  NoteDetailViewController.swift
//  NotesManager
//
//  Created by pnam on 06/08/2022.
//

@_implementationOnly import UIKit

final class NoteDetailViewController: UIViewController {
    var viewModel: NoteDetailViewModel!
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.update(
            backroundColor: viewModel.note.color,
            titleColor: .black
        )
    }
    
    private func setupView() {
        hero.modalAnimationType = .zoom
        descriptionLabel.text = viewModel.note.description
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy hh:mm"
        let createAt = dateFormatter.string(from: Date(milliseconds: viewModel.note.createAt))
        let updateAt = dateFormatter.string(from: Date(milliseconds: viewModel.note.updateAt))
        timeLabel.text = "\(createAt) - \(updateAt)"
        view.backgroundColor = viewModel.note.color
    }
}

// MARK: - Action
private extension NoteDetailViewController {
    @objc func editNoteAction(_ sender: UIBarButtonItem) {
        let viewModel: ConfigNoteViewModel = ConfigNoteViewModelImpl(note: viewModel.note)
        let viewController = ConfigNoteViewController(viewModel: viewModel)
        let navigation = UINavigationController(rootViewController: viewController)
        present(navigation, animated: true) { [weak self] in
            
        }
    }
    
    @objc func deleteNoteAction(_ sender: UIBarButtonItem) {
        
    }
}
