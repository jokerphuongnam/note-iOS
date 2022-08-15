//
//  ConfigNoteViewController.swift
//  NotesManager
//
//  Created by pnam on 14/08/2022.
//

@_implementationOnly import UIKit
@_implementationOnly import RxSwift

final class ConfigNoteViewController: UIViewController {
    static let elementColorName = "elementColorName"
    static let paletteColorCellName = String(describing: PaletteColorCell.self)
    static let timeAnimation = 0.3
    
    var viewModel: ConfigNoteViewModel!
    let disposeBag: DisposeBag = DisposeBag()
    typealias Completion = (_ note: Note) -> ()
    var completion: Completion!
    var isShowTitle: Bool = false {
        willSet {
            configTitleButton.setImage(UIImage(systemName: !newValue ? "plus" : "minus"), for: .normal)
            descriptionViewContraintTop.priority = .init(rawValue: newValue ? 1000 : 400)
            UIView.animate(withDuration: Self.timeAnimation) { [weak self] in
                guard let self = self else { return }
                self.view.layoutIfNeeded()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + Self.timeAnimation) { [weak self] in
                guard let self = self else { return }
                self.configTitleButton.isEnabled = true
                if newValue {
                    self.titleTextField.isHidden = !newValue
                }
            }
            if !newValue {
                titleTextField.isHidden = !newValue
            } else {
            }
        }
    }
    var isShowDescription: Bool = false {
        willSet {
            configDescriptionButton.setImage(UIImage(systemName: !newValue ? "plus" : "minus"), for: .normal)
            colorViewConstraintTop.priority = .init(rawValue: newValue ? 1000 : 400)
            UIView.animate(withDuration: Self.timeAnimation) { [weak self] in
                guard let self = self else { return }
                self.view.layoutIfNeeded()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + Self.timeAnimation) { [weak self] in
                guard let self = self else { return }
                self.configDescriptionButton.isEnabled = true
                if newValue {
                    self.descriptionTextView.isHidden = !newValue
                }
            }
            if !newValue {
                descriptionTextView.isHidden = !newValue
            }
        }
    }
    var selectedPaletteColor: UIColor = .white
    lazy var optionColors: [UIColor] = Self.optionColors
    
    @IBOutlet weak var configTitleButton: UIButton!
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var configDescriptionButton: UIButton!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var descriptionViewContraintTop: NSLayoutConstraint!
    @IBOutlet weak var descriptionTextViewContraintHeight: NSLayoutConstraint!
    
    @IBOutlet weak var colorReviewView: UIView!
    @IBOutlet weak var colorCollectionView: UICollectionView!
    @IBOutlet weak var colorViewConstraintTop: NSLayoutConstraint!
    
    init(viewModel: ConfigNoteViewModel) {
        super.init(nibName: String(describing: Self.self), bundle: Bundle.main)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        viewModel = nil
        completion = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        colorCollectionView.collectionViewLayout = layout
        colorCollectionView.dataSource = self
        colorCollectionView.delegate = self
        colorCollectionView.register(
            UICollectionViewCell.self,
            forCellWithReuseIdentifier: Self.elementColorName
        )
        colorCollectionView.register(
            UINib(nibName: Self.paletteColorCellName, bundle: Bundle.main),
            forCellWithReuseIdentifier: Self.paletteColorCellName
        )
        titleTextField.delegate = self
        descriptionTextView.delegate = self
        let note = viewModel.note
        isShowTitle = note.title != nil
        titleTextField.text = note.title
        isShowDescription = note.description != nil
        descriptionTextView.text = note.description
        colorReviewView.backgroundColor = note.color
        title = viewModel.action.title
        view.backgroundColor = Asset.Colors.background.color
        descriptionTextViewContraintHeight.constant = titleTextField.frame.height
        descriptionTextView.contentInset = .init(top: 0, left: 8, bottom: 0, right: 8)
    }
}

// MARK: - Action
extension ConfigNoteViewController {
    @IBAction func configTitleButton(_ sender: UIButton, forEvent event: UIEvent) {
        switch sender {
        case configTitleButton:
            isShowTitle.toggle()
        case configDescriptionButton:
            isShowDescription.toggle()
        default: break
        }
        sender.isEnabled = false
    }
    
    @IBAction func noteEditingChanged(_ sender: UITextField) {
        switch sender {
        case titleTextField:
            viewModel.note.title = sender.text
        default: break
        }
    }
    
    @IBAction func confirmAction(_ sender: UIButton, forEvent event: UIEvent) {
        let loadingContentViewController = LoadingAlertController()
        let loadingAlertController = loadingContentViewController.alertController
        loadingContentViewController.messageLabel.text = Strings.loading
        present(loadingAlertController, animated: true)
        viewModel.confirmAction()
            .subscribe { [weak self] note in
                loadingAlertController.dismiss(animated: true)
                guard let self = self else { return }
                self.completion?(note)
                let alertController = UIAlertController(title: self.viewModel.action.title, message: Strings.success, preferredStyle: .alert)
                let okAction = UIAlertAction(title: Strings.ok, style: .default) { [weak self] action in
                    guard let self = self else { return }
                    self.dismiss(animated: true)
                }
                okAction.titleTextColor = Asset.Colors.main.color
                alertController.addAction(okAction)
                self.present(alertController, animated: true)
            } onFailure: { [weak self] error in
                loadingAlertController.dismiss(animated: true)
                guard let self = self else {  return }
                let message: String
                switch error {
                case ApiError.unknownError(let responseError):
                    message = responseError.message ?? ""
                case ApiError.otherError(let responseError):
                    message = "\(Strings.unknownError): \(responseError.statusCode ?? 0)"
                default:
                    message = error.localizedDescription
                }
                let alertController = UIAlertController(title: Strings.error, message: message, preferredStyle: .alert)
                let okAction = UIAlertAction(title: Strings.ok, style: .default) { [weak self] action in
                    self?.dismiss(animated: true)
                }
                okAction.titleTextColor = Asset.Colors.red.color
                alertController.addAction(okAction)
                self.present(alertController, animated: true)
            } onDisposed: {
                
            }
            .disposed(by: disposeBag)

    }
}
