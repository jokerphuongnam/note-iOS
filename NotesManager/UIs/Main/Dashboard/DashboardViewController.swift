//
//  DashboardViewController.swift
//  NotesManager
//
//  Created by pnam on 04/08/2022.
//

@_implementationOnly import UIKit
@_implementationOnly import RxSwift
@_implementationOnly import Hero

final class DashboardViewController: UICollectionViewController {
    static let noteVerticalCellName = String(describing: NoteVerticalCell.self)
    static let noteGridCellName = String(describing: NoteGridCell.self)
    
    private let disposeBag = DisposeBag()
    var viewModel: DashboardViewModel!
    var layoutType: DashboardLayout = .vertical
    
    lazy var settingButton: UIBarButtonItem = { [weak self] in
        guard let self = self else {
            return UIBarButtonItem(image: Asset.Assets.humburger.image, style: .plain, target: nil, action: #selector(settingAction))
        }
        return UIBarButtonItem(image: Asset.Assets.humburger.image, style: .plain, target: self, action: #selector(settingAction))
    }()
    
    lazy var layoutChangeButton: UIBarButtonItem = { [weak self] in
        guard let self = self else {
            return UIBarButtonItem(image: Asset.Assets.list.image, style: .plain, target: nil, action: #selector(addAction))
        }
        return UIBarButtonItem(image: self.layoutType == .grid ? Asset.Assets.list.image : Asset.Assets.grid.image, style: .plain, target: self, action: #selector(layoutChangeAction))
    }()
    
    lazy var addButton: UIBarButtonItem = { [weak self] in
        let imageView = UIImageView(image: UIImage(systemName: "plus"))
        imageView.hero.isEnabled = true
        imageView.hero.id = ""
        let tapGesture: UITapGestureRecognizer
        if let self = self {
            tapGesture = UITapGestureRecognizer(target: self, action: #selector(addAction))
        } else {
            tapGesture = UITapGestureRecognizer(target: nil, action: #selector(addAction))
        }
        return UIBarButtonItem(customView: imageView)
    }()
    
    init(viewModel: DashboardViewModel) {
        super.init(collectionViewLayout: .init())
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
    
    private func setupView() {
        collectionView.collectionViewLayout = layout
        collectionView.register(
            UINib(nibName: Self.noteVerticalCellName, bundle: nibBundle),
            forCellWithReuseIdentifier: Self.noteVerticalCellName
        )
        collectionView.register(
            UINib(nibName: Self.noteGridCellName, bundle: nibBundle),
            forCellWithReuseIdentifier: Self.noteGridCellName
        )
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        view.backgroundColor = Asset.Colors.background.color
        hero.isEnabled = true
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

// MARK: - Action
private extension DashboardViewController {
    @objc func settingAction(_ sender: UIBarButtonItem) {
        let viewController = SettingViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @objc func layoutChangeAction(_ sender: UIBarButtonItem) {
        layoutType = layoutType == .vertical ? .grid : .vertical
        collectionView.reloadData()
        sender.image = layoutType == .grid ? Asset.Assets.list.image : Asset.Assets.grid.image
    }
    
    @objc func addAction(_ sender: UIBarButtonItem) {
        
    }
}
