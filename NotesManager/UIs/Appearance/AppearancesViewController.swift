//
//  AppearancesViewController.swift
//  NotesManager
//
//  Created by pnam on 08/08/2022.
//

@_implementationOnly import UIKit

final class AppearancesViewController: UICollectionViewController {
    static let simpleAppearanceCellName = String(describing: SimpleAppearanceCell.self)
    static let customAppearanceCellName = String(describing: CustomAppearanceCell.self)
    
    var viewModel: AppearancesViewModel!
    var appearances = Appearance.allCases
    
    init(viewModel: AppearancesViewModel) {
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
        collectionView.setCollectionViewLayout(flowLayout, animated: true)
        collectionView.register(
            UINib(nibName: Self.simpleAppearanceCellName, bundle: Bundle.main),
            forCellWithReuseIdentifier: Self.simpleAppearanceCellName
        )
        collectionView.register(
            UINib(nibName: Self.customAppearanceCellName, bundle: Bundle.main),
            forCellWithReuseIdentifier: Self.customAppearanceCellName
        )
        collectionView.delegate = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        view.backgroundColor = Asset.Colors.background.color
        collectionView.reloadData()
    }
}
