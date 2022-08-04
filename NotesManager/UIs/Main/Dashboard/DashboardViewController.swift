//
//  DashboardViewController.swift
//  NotesManager
//
//  Created by pnam on 04/08/2022.
//

@_implementationOnly import UIKit
@_implementationOnly import RxSwift

private let reuseIdentifier = "Cell"

protocol DashboardViewControllerDelegate: AnyObject {
    func dashboard(_ viewController: DashboardViewController, viewDidAppear animated: Bool)
}

class DashboardViewController: UICollectionViewController {
    static let noteCellName = String(describing: NoteCell.self)
    private weak var delegate: DashboardViewControllerDelegate!
    var viewModel: DashboardViewModel!
    private let disposeBag = DisposeBag()
    
    lazy var addButton: UIBarButtonItem = { [weak self] in
        guard let self = self else { return UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: nil, action: #selector(addAction)) }
        let addButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addAction))
        return addButton
    }()
    
    init(
        delegate: DashboardViewControllerDelegate? = nil,
        viewModel: DashboardViewModel
    ) {
        super.init(
            collectionViewLayout: UICollectionViewCompositionalLayout { (numberOfSection ,env) in
                let item = NSCollectionLayoutItem(
                    layoutSize: .init(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .fractionalHeight(1)
                    )
                )
                let group = NSCollectionLayoutGroup.vertical(
                    layoutSize: .init(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .absolute(50)
                    ),
                    subitems: [item]
                )
                let section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 16
                section.contentInsets.bottom = 16
                return section
            }
        )
        self.delegate = delegate
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupLiveData()
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        resumeNavigationBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        delegate?.dashboard(self, viewDidAppear: animated)
    }
    
    private func setupView() {
        collectionView.register(
            UINib(nibName: Self.noteCellName, bundle: nibBundle),
            forCellWithReuseIdentifier: Self.noteCellName
        )
    }
    
    private func setupLiveData() {
        viewModel.notesObserver
            .subscribe { resource in
                switch resource {
                case .next(let data):
                    switch data {
                    case .`init`:
                        print("init")
                    case .loading:
                        print("loading")
                    case .success(data: let data):
                        print(data)
                    }
                case .error(let error):
                    print(error)
                case .completed:
                    print("completed")
                }
            }
            .disposed(by: disposeBag)
        viewModel.reloadNotes()
    }
}

// MARK: Action
private extension DashboardViewController {
    @objc func addAction(_ sender: UIBarButtonItem) {
        
    }
}
