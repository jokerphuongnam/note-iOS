//
//  ConfigNoteViewController.swift
//  NotesManager
//
//  Created by pnam on 06/08/2022.
//

@_implementationOnly import UIKit

final class ConfigNoteViewController: UICollectionViewController {
    static let configHeaderViewName = String(describing: ConfigHeaderView.self)
    static let titleHeader = "Title Header"
    static let descriptionHeader = "Description Header"
    static let textCellName = String(describing: TextCell.self)
    static let colorHeaderViewName = String(describing: ColorHeaderView.self)
    static let elementColorName = "elementColorName"
    static let paletteColorCellName = String(describing: PaletteColorCell.self)
    
    var viewModel: ConfigNoteViewModel!
    var isShowTitle: Bool = true
    var isShowDescription: Bool = false
    var selectedPaletteColor: UIColor = .white
    lazy var optionColors: [UIColor] = Self.optionColors
    
    init(viewModel: ConfigNoteViewModel) {
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
    }
    
    private func setupView() {
        collectionView.collectionViewLayout = layout
        collectionView.register(
            UINib(nibName: Self.configHeaderViewName, bundle: Bundle.main),
            forSupplementaryViewOfKind: Self.titleHeader,
            withReuseIdentifier: Self.titleHeader
        )
        collectionView.register(
            UINib(nibName: Self.configHeaderViewName, bundle: Bundle.main),
            forSupplementaryViewOfKind: Self.descriptionHeader,
            withReuseIdentifier: Self.descriptionHeader
        )
        collectionView.register(
            UINib(nibName: Self.textCellName, bundle: Bundle.main),
            forCellWithReuseIdentifier: Self.textCellName
        )
        collectionView.register(
            UINib(nibName: Self.colorHeaderViewName, bundle: Bundle.main),
            forSupplementaryViewOfKind: Self.colorHeaderViewName,
            withReuseIdentifier: Self.colorHeaderViewName
        )
        collectionView.register(
            UICollectionViewCell.self,
            forCellWithReuseIdentifier: Self.elementColorName
        )
        collectionView.register(
            UINib(nibName: Self.paletteColorCellName, bundle: Bundle.main),
            forCellWithReuseIdentifier: Self.paletteColorCellName
        )
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        isShowTitle = viewModel.note.title != nil
        isShowDescription = viewModel.note.description != nil
        title = viewModel.title
    }
}
