//
//  String+Extension.swift
//  NKPhoneInputView
//
//  Created by Nick Kopilovskii on 7/31/19.
//

import UIKit

extension String {
  fileprivate static let cBackspaceUNICodeString = "\\b"
  fileprivate static let cBackspaceUNICode = -92
  
  func catchBackspace() -> Bool {
    if let char = cString(using: String.Encoding.utf8) {
      let isBackSpace = strcmp(char, String.cBackspaceUNICodeString)
      if isBackSpace == String.cBackspaceUNICode {
        return true
      }
    }
    return false
  }
  
  func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
    let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
    let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
    
    return ceil(boundingBox.height)
  }
  
  func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
    let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
    let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
    
    return ceil(boundingBox.width)
  }
  
  func substring(_ r: Range<Int>) -> String {
    let fromIndex = self.index(self.startIndex, offsetBy: r.lowerBound)
    let toIndex = self.index(self.startIndex, offsetBy: r.upperBound)
    let indexRange = Range<String.Index>(uncheckedBounds: (lower: fromIndex, upper: toIndex))
    return String(self[indexRange])
  }
  
}
