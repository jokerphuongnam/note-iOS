//
//  CustomAppearanceCell.swift
//  NotesManager
//
//  Created by pnam on 08/08/2022.
//

@_implementationOnly import UIKit

class CustomAppearanceCell: UICollectionViewCell {
    private static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter
    }()
    @IBOutlet weak var checkImageView: UIImageView!
    
    @IBOutlet weak var timeView: UIView!
    @IBOutlet weak var startTimeTextField: UITextField!
    @IBOutlet weak var endTimeTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setSelected(startTime: Int, endTime: Int) {
        checkImageView.isHidden = false
        timeView.isHidden = false
        startTimeTextField.text = Self.dateFormatter.string(from: .init(milliseconds: Int64(startTime)))
        endTimeTextField.text = Self.dateFormatter.string(from: .init(milliseconds: Int64(endTime)))
    }
    
    func unSelected() {
        checkImageView.isHidden = true
        timeView.isHidden = true
    }
}

// MARK: - Action
private extension CustomAppearanceCell {
    @IBAction private func editingFinished(_ sender: UITextField, forEvent event: UIEvent) {
        let currentInput = sender.text!
        if currentInput.count > 5 || currentInput.count < 3 {   // Refuse more than 5 chars as 23:59 or less than 3 chars but accepts 123 as 1:23
            sender.text = ""    // Clear it
            // Could play a beep
            return
        }
        
        let posOfColon = currentInput.firstIndex(of: ":")
        let withColon = posOfColon != nil
        var hh = ""
        var mm = ""
        
        if withColon {
            hh = String(currentInput[..<posOfColon!])
            let mmIndex = currentInput.index(posOfColon!, offsetBy: 1)
            mm = String(currentInput[mmIndex...])
        } else {
            mm = String(currentInput.suffix(2))     // Always 2 digits for minutes
            if currentInput.count == 4 {  // format as 1234
                hh = String(currentInput.prefix(2))     // first 2 digits
            } else {  // Only 3 chars
                hh = String(currentInput.prefix(1))     // Only one digit here
            }
        }
        if Int(hh) == nil || Int(hh)! > 23  {
            sender.text = ""    // Clear it
            // Could play a beep
            return
        }
        if Int(mm) == nil || Int(mm)! > 59  {
            sender.text = ""    // Clear it
            // Could play a beep
            return
        }
        
        // Use hh and mm as needed
    }
    
    @IBAction private func clockAction(_ sender: UIButton, forEvent event: UIEvent) {
        
    }
}

// MARK: - UITextFieldDelegate
extension CustomAppearanceCell: UITextFieldDelegate {
    
}
