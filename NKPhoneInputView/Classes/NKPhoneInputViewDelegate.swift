//
//  NKPhoneInputViewDelegate.swift
//  NKPhoneInputView
//
//  Created by Nick Kopilovskii on 7/31/19.
//

import UIKit

public protocol PhoneInputViewDelegate: class {
  func didBeginEditing(_ phoneInputView: NKPhoneInputView)
  func needsEnterCode(_ phoneInputView: NKPhoneInputView)
  func didFinishEditing(_ phoneInputView: NKPhoneInputView)
}
