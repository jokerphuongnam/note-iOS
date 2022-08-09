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
        startTimeTextField.delegate = self
        endTimeTextField.delegate = self
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
    
    // MARK: - validate minutes
    fileprivate func validate(_ sender: UITextField, minutes string: String) {
        if let minutes = Int(string), minutes > 59 {
            var m = String(minutes % 60)
            if m.count == 1 {
                m.insert("0", at: m.startIndex)
            }
            
            sender.text = sender.text?.replacingOccurrences(of: string, with: m)
        }
    }
    
    // MARK: - validate hours
    fileprivate func validate(_ sender: UITextField, hours string: String) {
        if let hours = Int(string), hours > 23 {
            var h = String(hours % 24)
            if h.count == 1 {
                h.insert("0", at: h.startIndex)
            }
            
            sender.text = sender.text?.replacingOccurrences(of: string, with: h)
        }
    }
}

// MARK: - Action
private extension CustomAppearanceCell {
    @IBAction private func textFieldDidChanged(_ sender: UITextField, forEvent event: UIEvent) {
        guard let text = sender.text else { return }
        let split = text.split(separator: ":")
        if split.count > 1, let minutes = split.last {
            validate(sender, minutes: String(minutes))
        }
        if let hours = split.first {
            validate(sender, hours: String(hours))
        }
    }
    
    @IBAction func textFieldDidEnd(_ sender: UITextField, forEvent event: UIEvent) {
        guard let text = sender.text else { return }
        let split = text.split(separator: ":")
        if split.count > 1 {
            if let minutes = split.last, minutes.count == 2 {
                validate(sender, minutes: String(minutes))
            } else {
                sender.text?.insert("0", at: text.index(text.startIndex, offsetBy: 3))
            }
        } else {
            sender.text = text + ":00"
        }
        
        if let hours = split.first, hours.count == 2 {
            validate(sender, hours: String(hours))
        } else {
            if text.isEmpty {
                sender.text?.insert("0", at: text.startIndex)
            }
            sender.text?.insert("0", at: text.startIndex)
        }
    }
    
    
    @IBAction private func clockAction(_ sender: UIButton, forEvent event: UIEvent) {
        
    }
}

// MARK: - UITextFieldDelegate
extension CustomAppearanceCell: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text, (text + string).count < 6 else {
            return false
        }
        if let index = text.firstIndex(of:":"), text.distance(from: text.startIndex, to: index) == 1 {
            textField.text = "0" + text
            return false
        }
        
        if text.count < 2, string == ":" && !text.contains(":") {
            textField.text = text.isEmpty ? "00" : "0" + text
        }
        
        guard string.isEmpty || string.first?.isWholeNumber ?? false else {
            return false
        }
        
        if string.isEmpty, text.count == 4 {
            if let index = text.firstIndex(of: ":") {
                let substr = text.prefix(through: index)
                textField.text = String(substr)
            }
        } else if !string.isEmpty, text.count == 2 {
            textField.text = text + ":"
        }
        return true
    }
}
