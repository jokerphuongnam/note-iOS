//
//  CustomAppearanceCell.swift
//  NotesManager
//
//  Created by pnam on 08/08/2022.
//

@_implementationOnly import UIKit

@objc protocol CustomAppearanceCellDelegate {
    @objc optional func customAppearance(_ customAppearanceCell: CustomAppearanceCell, didTapClockAction textField: UITextField, sender: UIButton, forEvent event: UIEvent)
    @objc optional func customAppearance(_ customAppearanceCell: CustomAppearanceCell, startTime: Int64, endTime: Int64)
}

class CustomAppearanceCell: UICollectionViewCell {
    weak var delegate: CustomAppearanceCellDelegate!
    private static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter
    }()
    @IBOutlet weak var checkImageView: UIImageView!
    
    @IBOutlet weak var timeView: UIView!
    @IBOutlet weak var startTimeTextField: UITextField!
    @IBOutlet weak var endTimeTextField: UITextField!
    
    fileprivate var datePicker:UIDatePicker = UIDatePicker()
    fileprivate let toolBar = UIToolbar()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        startTimeTextField.delegate = self
        endTimeTextField.delegate = self
    }
    
    func setSelected(startTime: Int64, endTime: Int64) {
        checkImageView.isHidden = false
        timeView.isHidden = false
        startTimeTextField.text = Self.dateFormatter.string(from: .init(milliseconds: startTime))
        endTimeTextField.text = Self.dateFormatter.string(from: .init(milliseconds: endTime))
    }
    
    func unSelected() {
        checkImageView.isHidden = true
        timeView.isHidden = true
    }
    
    func updateTime(handler: ((_ startTime: Int64, _ endTime: Int64) -> ())? = nil) {
        guard let startTime = startTimeTextField.text, let endTime = endTimeTextField.text else { return }
        guard let startTime = Self.dateFormatter.date(from: startTime), let endTime = Self.dateFormatter.date(from: endTime) else { return }
        textFieldDidEnd(startTimeTextField)
        textFieldDidEnd(endTimeTextField)
        if let handler = handler {
            handler(
                startTime.millisecondsSince1970,
                endTime.millisecondsSince1970
            )
        } else {
            delegate?.customAppearance?(
                self,
                startTime: startTime.millisecondsSince1970,
                endTime: endTime.millisecondsSince1970
            )
        }
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
    
    func textFieldDidEnd(_ sender: UITextField) {
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
        textFieldDidEnd(sender)
        updateTime()
    }
    
    @IBAction private func clockAction(_ sender: UIButton, forEvent event: UIEvent) {
        delegate?.customAppearance?(self, didTapClockAction: sender.tag == 1 ? startTimeTextField : endTimeTextField, sender: sender, forEvent: event)
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
