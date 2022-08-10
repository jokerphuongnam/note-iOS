//
//  ScrollLoadingView.swift
//  NotesManager
//
//  Created by pnam on 10/08/2022.
//

@_implementationOnly import UIKit

class ScrollLoadingView: UIView {
    @IBOutlet private var contentView: UIView!
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        Bundle.main.loadNibNamed(String(describing: Self.self), owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
}
