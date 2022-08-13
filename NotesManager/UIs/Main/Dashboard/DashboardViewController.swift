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
    var loadingType: UIScrollView.ScrollLoadingType!
    
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
        let buttonView = UIButton()
        buttonView.hero.isEnabled = true
        buttonView.heroID = "note"
        buttonView.setImage(UIImage(systemName: "plus"), for: .normal)
        if let self = self {
            buttonView.addTarget(self, action: #selector(addAction), for: .touchUpInside)
        } else {
            buttonView.addTarget(nil, action: #selector(addAction), for: .touchUpInside)
        }
        return UIBarButtonItem(customView: buttonView)
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.update(
            backroundColor: Asset.Colors.background.color,
            titleColor: Asset.Colors.text.color
        )
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
            .subscribe(on: SerialDispatchQueueScheduler.init(qos: .utility))
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] resource in
                guard let self = self else { return }
                switch resource {
                case .next(let data):
                    switch data {
                    case .`init`: break
                    case .loading: break
                    case .success(data: _):
                        self.viewModel.isLoading = false
                        self.collectionView.removeLoadingView()
                        self.collectionView.reloadData()
                    }
                case .error(_):
                    self.viewModel.isLoading = false
                    self.collectionView.removeLoadingView()
                    self.collectionView.reloadData()
                case .completed:
                    print("completed")
                }
            }
            .disposed(by: disposeBag)
        viewModel.reloadNotes(searchWords: nil)
    }
}

// MARK: - Action
private extension DashboardViewController {
    @objc func settingAction(_ sender: UIBarButtonItem) {
        let viewModel: SettingViewModel = SettingViewModelImpl()
        let viewController = SettingViewController(viewModel: viewModel)
        let navigation = UINavigationController(rootViewController: viewController)
        present(navigation, animated: true)
    }
    
    @objc func layoutChangeAction(_ sender: UIBarButtonItem) {
        layoutType = layoutType == .vertical ? .grid : .vertical
        collectionView.setCollectionViewLayout(layout, animated: true)
        sender.image = layoutType == .grid ? Asset.Assets.list.image : Asset.Assets.grid.image
    }
    
    @objc func addAction(_ sender: UIButton, forEvent event: UIEvent) {
        let viewModel: ConfigNoteViewModel = ConfigNoteViewModelImpl()
        let viewController = ConfigNoteViewController(viewModel: viewModel)
        let navigation = UINavigationController(rootViewController: viewController)
        present(navigation, animated: true)
    }
}
