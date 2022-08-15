//
//  Color+.swift
//  NotesManager
//
//  Created by pnam on 02/08/2022.
//

@_implementationOnly import UIKit

extension UIColor {
    // MARK: - Init from HexString
    convenience init(hex:String) {
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            self.init(white: 1, alpha: 0.5)
        }
        
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    // MARK: - string hex
    var stringHex: String {
        let components = cgColor.components
        let r: CGFloat = componentsIndex(components, index: 0)
        let g: CGFloat = componentsIndex(components, index: 1)
        let b: CGFloat = componentsIndex(components, index: 2)
        let hexString = String.init(format: "#%02lX%02lX%02lX", lroundf(Float(r * 255)), lroundf(Float(g * 255)), lroundf(Float(b * 255)))
        return hexString
    }
    
    private func componentsIndex(_ components: [CGFloat]?, index: Int) -> CGFloat {
        if components?.count ?? 0 < index + 1 {
            return 0
        } else {
            return components?[index] ?? 0.0
        }
    }
}
