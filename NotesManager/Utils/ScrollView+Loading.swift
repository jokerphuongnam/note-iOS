//
//  ScrollView+Loading.swift
//  NotesManager
//
//  Created by pnam on 10/08/2022.
//

@_implementationOnly import UIKit

extension UIScrollView {
    private var scrollLoadingView: UIView! {
        for subView in subviews {
            if !(subView is UICollectionReusableView)  {
                return subView
            }
        }
        return nil
    }
    
    typealias LoadingConfig<T: UIView> = (_ scrollViewLoading: T) -> ()
    
    func addLoadingView<T>(isLoading: inout Bool, reloadConfig reload: LoadingConfig<T>?, loadMoreConfig loadMore: LoadingConfig<T>?) where T: UIView {
        let position = contentOffset.y
        guard !isLoading, scrollLoadingView == nil, contentSize.height != 0 else {
            return
        }
        let scrollViewHeight = frame.height
        let v: T
        if position > contentSize.height - 100 - scrollViewHeight {
            v = .init(frame: .init(x: 0, y: contentSize.height + scrollViewHeight - scrollViewHeight + 20, width: frame.size.width, height: 80))
            contentInset = .init(top: 0, left: 0, bottom: 100, right: 0)
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                loadMore?(v)
                self.addSubview(v)
            }
            isLoading.toggle()
        } else if position < -adjustedContentInset.top {
            v = .init(frame: .init(x: 0, y: -100, width: frame.size.width, height: 80))
            contentInset = .init(top: 100, left: 0, bottom: 0, right: 0)
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                reload?(v)
                self.addSubview(v)
            }
            isLoading.toggle()
        }
    }
    
    typealias LoadingHandle = (_ type: ScrollLoadingType) -> ()
    func defaultLoadingView(isLoading: inout Bool, reloadTitle reload: String? = nil, loadMoreTitle loadMore: String? = nil, LoadingHandle handle: LoadingHandle? = nil) {
        addLoadingView(isLoading: &isLoading) { [weak self] (scrollViewLoading: ScrollLoadingView) in
            guard let self = self else { return }
            scrollViewLoading.titleLabel.text = reload ?? "Pull To Reload"
            handle?(.reload)
        } loadMoreConfig: { [weak self] (scrollViewLoading: ScrollLoadingView) in
            guard let self = self else { return }
            scrollViewLoading.titleLabel.text = loadMore ?? "Pull To LoadMore"
            handle?(.loadMore)
        }
    }
    
    func removeLoadingView() {
        for subView in subviews {
            if subView is ScrollLoadingView {
                subView.removeFromSuperview()
                contentInset = .init(top: 0, left: 0, bottom: 0, right: 0)
                return
            }
        }
    }
}

extension UIScrollView {
    enum ScrollLoadingType {
        case reload
        case loadMore
    }
}
