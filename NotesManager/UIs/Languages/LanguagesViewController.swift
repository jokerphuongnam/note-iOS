//
//  LanguagesViewController.swift
//  NotesManager
//
//  Created by pnam on 08/08/2022.
//

@_implementationOnly import UIKit

final class LanguagesViewController: UICollectionViewController {
    static let languageCellName = String(describing: LanguageCell.self)
    
    var viewModel: LanguagesViewModel!
    let languages = Language.allCases
    
    init(viewModel: LanguagesViewModel) {
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
    
    private func setupView() {
        collectionView.collectionViewLayout = layout
        collectionView.register(
            UINib(nibName: Self.languageCellName, bundle: Bundle.main),
            forCellWithReuseIdentifier: Self.languageCellName
        )
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        view.backgroundColor = Asset.Colors.background.color
    }
}
