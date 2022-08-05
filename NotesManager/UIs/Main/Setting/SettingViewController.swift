//
//  SettingViewController.swift
//  NotesManager
//
//  Created by pnam on 04/08/2022.
//

@_implementationOnly import UIKit

class SettingViewController: UICollectionViewController {
    static let settingCellName = String(describing: SettingCell.self)
    static let logoutViewName = String(describing: LogoutView.self)
    
    var options = Option.allCases
    
    init() {
        super.init(collectionViewLayout: .init())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print(String(describing: Self.self))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNavigationBar()
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
