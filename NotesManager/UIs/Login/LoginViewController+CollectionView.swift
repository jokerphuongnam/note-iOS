//
//  LoginViewController+CollectionView.swift
//  NotesManager
//
//  Created by pnam on 13/08/2022.
//

@_implementationOnly import UIKit

extension LoginViewController {
    var layout: UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { [weak self] numberOfSection, env in
            guard let self = self else {
                return nil
            }
            var config = UICollectionLayoutListConfiguration(appearance: .plain)
            config.showsSeparators = false
            config.trailingSwipeActionsConfigurationProvider = { [weak self] indexPath in
                guard let self = self else {
                    return UISwipeActionsConfiguration()
                }
                let deleteAction = UIContextualAction(style: .destructive, title: nil) { action, view, completion in
                    let emailRecommend = self.viewModel.emailsRecommend
                    if emailRecommend.count != 0 {
                        self.viewModel.deleteEmailRecommend(email: emailRecommend[indexPath.item])
                        self.recommendCollectionView.reloadData()
                        self.viewModel.getEmailsRecommend(searchWords: self.emailTextField.text ?? "")
                    }
                }
                deleteAction.image = UIImage(systemName: "trash")
                return UISwipeActionsConfiguration(actions: [deleteAction])
            }
            config.backgroundColor = Asset.Colors.gray.color
            let section = NSCollectionLayoutSection.list(using: config, layoutEnvironment: env)
            return section
        }
    }
}

// MARK: - UICollectionViewDataSource
extension LoginViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.emailsRecommend.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Self.recommendEmailCellName, for: indexPath) as? RecommendEmailCell {
            cell.titleLabel.text = viewModel.emailsRecommend[indexPath.item]
            return cell
        }
        fatalError()
    }
}

// MARK: - UICollectionViewDelegate
extension LoginViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0, let login = try? viewModel.getLogin(email: viewModel.emailsRecommend[indexPath.item]) {
            emailTextField.text = login.email
            passwordTextField.text = login.password
            emailTextField.resignFirstResponder()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.size.width, height: 50)
    }
}
