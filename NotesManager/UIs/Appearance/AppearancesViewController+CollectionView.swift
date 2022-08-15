//
//  AppearancesViewController+CollectionView.swift
//  NotesManager
//
//  Created by pnam on 08/08/2022.
//

@_implementationOnly import UIKit

// MARK: - layout
extension AppearancesViewController {
    var flowLayout: UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = .init(width: collectionView.frame.width - 32, height: 200)
        layout.sectionInset = .init(top: 0, left: 16, bottom: 0, right: 16)
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 16
        return layout
    }
}

// MARK: - UICollectionViewDataSource
extension AppearancesViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        appearances.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let appearance = appearances[indexPath.item]
        if indexPath.item < appearances.count - 1,
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Self.simpleAppearanceCellName, for: indexPath) as? SimpleAppearanceCell {
            cell.titleLabel.text = appearance.mode
            cell.checkImageView.isHidden = viewModel.appearance != appearance
            return cell
        } else {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Self.customAppearanceCellName, for: indexPath) as? CustomAppearanceCell,
               case .custom(startDarkMode: let startTime, endDarkMode: let endTime) = appearance {
                if viewModel.appearance.equatable(compareAppearance: appearance) {
                    cell.setSelected(startTime: startTime, endTime: endTime)
                } else {
                    cell.unSelected()
                }
                cell.delegate = self
                return cell
            }
        }
        fatalError()
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension AppearancesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width - 32
        if indexPath.item < appearances.count - 1 {
            return .init(width: width, height: 50)
        } else {
            if viewModel.appearance.equatable(compareAppearance: appearances[indexPath.item]) {
                return .init(width: width, height: 200)
            } else {
                return .init(width: width, height: 50)
            }
        }
    }
    
    // MARK: - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        16
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let appearance = appearances[indexPath.item]
        if viewModel.appearance != appearance {
            viewModel.appearance = appearance
            collectionView.reloadData()
        }
    }
}

// MARK: - CustomAppearanceCellDelegate
extension AppearancesViewController: CustomAppearanceCellDelegate {
    func customAppearance(_ customAppearanceCell: CustomAppearanceCell, didTapClockAction textField: UITextField, sender: UIButton, forEvent event: UIEvent) {
        guard let text = textField.text else { return }
        let datePicker = UIDatePicker()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        if let date = dateFormatter.date(from: text) {
            datePicker.date = date
        }
        datePicker.datePickerMode = .time
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.frame = CGRect(x: 0, y: 40, width: 270, height: 160)
        
        let alertController = UIAlertController(title: Strings.pickTime, message: "\n\n\n\n\n\n\n\n\n", preferredStyle: .alert)
        alertController.view.addSubview(datePicker)
        
        NSLayoutConstraint.activate([
            datePicker.leadingAnchor.constraint(equalTo: alertController.view.leadingAnchor),
            datePicker.trailingAnchor.constraint(equalTo: alertController.view.trailingAnchor),
        ])
        
        let selectAction = UIAlertAction(title: Strings.ok, style: .default) { [weak self] alertAction in
            guard self != nil else { return }
            textField.text = dateFormatter.string(from: datePicker.date)
            customAppearanceCell.updateTime()
        }
        selectAction.titleTextColor = Asset.Colors.main.color
        
        let cancelAction = UIAlertAction(title: Strings.cancel, style: .cancel, handler: nil)
        cancelAction.titleTextColor = Asset.Colors.red.color
        
        alertController.addAction(selectAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true)
    }
    
    func customAppearance(_ customAppearanceCell: CustomAppearanceCell, startTime: Int64, endTime: Int64) {
        appearances[3] = .custom(
            startDarkMode: startTime,
            endDarkMode: endTime
        )
    }
}
