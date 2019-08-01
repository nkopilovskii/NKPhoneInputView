//
//  NKPhoneInputView.swift
//  NKPhoneInputView
//
//  Created by Nick Kopilovskii on 7/31/19.
//  Copyright © 2019 Nick Kopilovskii. All rights reserved.
//

import UIKit

public protocol PhoneInputViewDelegate: class {
  func didBeginEditing(_ phoneInputView: NKPhoneInputView)
  func needsEnterCode(_ phoneInputView: NKPhoneInputView)
  func didFinishEditing(_ phoneInputView: NKPhoneInputView)
}

class NKPhoneInputView: UIView {
  @IBOutlet var contentView: UIView!
  @IBOutlet private weak var lblPhoneNumber: UILabel!
  @IBOutlet private weak var txtCode: UITextField!
  @IBOutlet private weak var txtNumber: UITextField!
  
  @IBOutlet weak var constraintWidthTxtCode: NSLayoutConstraint!
  
  weak var delegate: PhoneInputViewDelegate?
  
  var phoneNumber = NKPhoneNumber() {
    didSet {
      
      txtCode.placeholder = phoneNumber.codePlaceholder
      txtNumber.placeholder = phoneNumber.phonePlaceholder
      
      guard let code = phoneNumber.code else {
        txtCode.text = nil
        txtNumber.text = nil
        return
      }
      
      txtCode.text = code.flag + " +" + code.phoneCode
      txtNumber.text = phoneNumber.number
      
      constraintWidthTxtCode.constant = txtCode.contentWidth
      layoutIfNeeded()
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    commonInit()
  }
  
  private func commonInit() {
    Bundle.main.loadNibNamed("PhoneInputView", owner: self, options: nil)
    addSubview(contentView)
    contentView.translatesAutoresizingMaskIntoConstraints = false
    contentView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
    contentView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
    contentView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
    contentView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    txtCode.placeholder = phoneNumber.codePlaceholder
    txtNumber.placeholder = phoneNumber.phonePlaceholder
    constraintWidthTxtCode.constant = txtCode.contentWidth
    layoutIfNeeded()
  }
  
}

extension NKPhoneInputView: UITextFieldDelegate {
  
  func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
    guard textField != txtCode else {
      delegate?.needsEnterCode(self)
      return false
    }
    
    guard phoneNumber.code != nil else {
      delegate?.needsEnterCode(self)
      return false
    }
    
    return true
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    guard textField == txtNumber else {
      delegate?.didFinishEditing(self)
      return
    }
  }
  
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    guard textField != txtCode else { return false }
    
    guard !string.catchBackspace() else { return true }
    
    return (textField.text?.count ?? 0 + string.count) < phoneNumber.numberLength
  }
  
}


