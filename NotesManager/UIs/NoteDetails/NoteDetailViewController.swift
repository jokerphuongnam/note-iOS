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
        guard let self = self else {
            return UIBarButtonItem(image: UIImage(systemName: "pencil"), style: .plain, target: nil, action: #selector(editNoteAction))
        }
        return UIBarButtonItem(image: UIImage(systemName: "pencil"), style: .plain, target: self, action: #selector(editNoteAction))
    }()
    
    lazy var deleteNoteButton: UIBarButtonItem = { [weak self] in
        guard let self = self else {
            return UIBarButtonItem(image: UIImage(systemName: "trash"), style: .plain, target: nil, action: #selector(deleteNoteAction))
        }
        return UIBarButtonItem(image: UIImage(systemName: "trash"), style: .plain, target: self, action: #selector(deleteNoteAction))
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

//MARK: - Action
private extension NoteDetailViewController {
    @objc func editNoteAction(_ sender: UIBarButtonItem) {
        
    }
    
    @objc func deleteNoteAction(_ sender: UIBarButtonItem) {
        
    }
}
