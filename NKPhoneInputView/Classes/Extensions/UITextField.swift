//
//  UITextField+Extensions.swift
//  NKPhoneInputView
//
//  Created by Nick Kopilovskii on 7/31/19.
//

import UIKit

extension UITextField {
  
  var contentWidth: CGFloat {
    var string = ""
    if let text = text, !text.isEmpty {
      string = text
    } else if let placeholder = placeholder, !placeholder.isEmpty {
      string = placeholder
    }
    
    return string.width(withConstrainedHeight: frame.height, font: font ?? UIFont())
  }
  
}

