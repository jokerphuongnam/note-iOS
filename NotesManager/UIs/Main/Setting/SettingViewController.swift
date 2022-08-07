//
//  SettingViewController.swift
//  NotesManager
//
//  Created by pnam on 04/08/2022.
//

@_implementationOnly import UIKit

final class SettingViewController: UICollectionViewController {
    static let settingCellName = String(describing: SettingCell.self)
    static let logoutViewName = String(describing: LogoutView.self)
    
    var viewModel: SettingViewModel!
    var options = Option.allCases
    
    init(viewModel: SettingViewModel) {
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
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configTitle()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        title = Strings.setting
    }
    
    private func setupView() {
        collectionView.collectionViewLayout = layout
        collectionView.register(
            UINib(nibName: Self.settingCellName, bundle: Bundle.main),
            forCellWithReuseIdentifier: Self.settingCellName
        )
        collectionView.register(
            UINib(nibName: Self.logoutViewName, bundle: Bundle.main),
            forSupplementaryViewOfKind: Self.logoutViewName,
            withReuseIdentifier: Self.logoutViewName
        )
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        view.backgroundColor = Asset.Colors.background.color
    }
}
