//
//  MainViewController.swift
//  NotesManager
//
//  Created by pnam on 03/08/2022.
//

@_implementationOnly import UIKit

class MainViewController: UIPageViewController {
    var currentIndex = 0
    fileprivate lazy var _viewControllers: [UIViewController] = [
        { [weak self] in
            let viewController: DashboardViewController
            if let self = self {
                viewController = DashboardViewController(delegate: self)
            } else {
                viewController = DashboardViewController()
            }
            let navigationController = UINavigationController(rootViewController: viewController)
            return navigationController
        }(),
        { [weak self] in
            let viewController: SettingViewController
            if let self = self {
                viewController = SettingViewController(delegate: self)
            } else {
                viewController = SettingViewController()
            }
            let navigationController = UINavigationController(rootViewController: viewController)
            return navigationController
        }()
    ]
    
    override var viewControllers: [UIViewController]? {
        _viewControllers
    }
    
    lazy var addButton: UIBarButtonItem = { [weak self] in
        guard let self = self else { return UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: nil, action: #selector(addAction)) }
        let addButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addAction))
        return addButton
    }()
    
    init() {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: [:])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        resumeNavigationBar()
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        navigationController?.setNavigationBarHidden(false, animated: animated)
//    }
    
    private func setupView() {
        delegate = self
        dataSource = self
        setViewControllers([viewControllers![0]], direction: .forward, animated: true)
    }
}

// MARK: Action
extension MainViewController {
    @objc private func addAction(_ sender: UIBarButtonItem) {
        
    }
}

// MARK: UIPageViewControllerDataSource
extension MainViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let viewControllers = _viewControllers
        if currentIndex >= viewControllers.count - 1 || viewControllers.count == 0 {
            return nil
        }
        if currentIndex == 0 {
            return nil
        }
        currentIndex -= 1
        return viewControllers[currentIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let viewControllers = _viewControllers
        if currentIndex >= viewControllers.count - 1 || viewControllers.count == 0 {
            return nil
        }
        if currentIndex == viewControllers.count {
            return nil
        }
        currentIndex += 1
        return viewControllers[currentIndex]
    }
}

// MARK: UIPageViewControllerDelegate
extension MainViewController: UIPageViewControllerDelegate {
    
}
