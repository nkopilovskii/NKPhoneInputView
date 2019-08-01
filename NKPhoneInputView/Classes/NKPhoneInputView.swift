//
//  NKPhoneInputView.swift
//  NKPhoneInputView
//
//  Created by Nick Kopilovskii on 7/31/19.
//  Copyright © 2019 Nick Kopilovskii. All rights reserved.
//

import UIKit



open class NKPhoneInputView: UIView {
  
  public var phoneNumber = NKPhoneNumber() {
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
      
      if subviews.contains(txtCode) {
        txtCode.widthAnchor.constraint(equalToConstant: txtCode.contentWidth).isActive = true
      }
      
      layoutIfNeeded()
    }
  }
  
  public weak var delegate: PhoneInputViewDelegate?
  
  public var title = "Enter phone number:" {
    didSet {
      configLblTitle()
    }
  }
  
  public var titleColor = UIColor.black{
    didSet {
      configLblTitle()
    }
  }
  
  public var titleFont = UIFont.systemFont(ofSize: 12){
    didSet {
      configLblTitle()
    }
  }
  
  
  
  public var textColor = UIColor.black {
    didSet {
      configTxtCode()
      configTxtNumber()
    }
  }
  
  public var textFont = UIFont.systemFont(ofSize: 14) {
    didSet {
      configTxtCode()
      configTxtNumber()
    }
  }
  
  public var contentInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8) {
    didSet {
      setupUI()
    }
  }
  
  public var contentElementsIndent = CGFloat(4) {
    didSet {
      setupUI()
    }
  }
  
  public var phoneElementsIndent = CGFloat(4) {
    didSet {
      setupTxtCode()
    }
  }
  
  private var lblTitle = UILabel()
  private var txtCode = UITextField()
  private var txtNumber = UITextField()
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
  }
  
  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setupUI()
  }
  
  override open func awakeFromNib() {
    super.awakeFromNib()
    txtCode.placeholder = phoneNumber.codePlaceholder
    txtNumber.placeholder = phoneNumber.phonePlaceholder
    
    txtCode.widthAnchor.constraint(equalToConstant: txtCode.contentWidth).isActive = true
    
    layoutIfNeeded()
  }
  
}


//MARK: - UITextFieldDelegate implementation
extension NKPhoneInputView: UITextFieldDelegate {
  
  public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
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
  
  public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
  
  public func textFieldDidEndEditing(_ textField: UITextField) {
    guard textField == txtNumber else {
      delegate?.didFinishEditing(self)
      return
    }
  }
  
  public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    guard textField != txtCode else { return false }
    
    guard !string.catchBackspace() else { return true }
    
    return (textField.text?.count ?? 0 + string.count) < phoneNumber.numberLength
  }
  
}


extension NKPhoneInputView {
  
  func setupUI() {
    setupLblTitle()
    setupTxtCode()
    setupTxtNumber()
    
    configLblTitle()
    configTxtCode()
    configTxtNumber()
  }
  
  func setupLblTitle() {
    addSubview(lblTitle)
    
    lblTitle.translatesAutoresizingMaskIntoConstraints = false
    lblTitle.topAnchor.constraint(equalTo: topAnchor, constant: contentInset.top).isActive = true
    lblTitle.leftAnchor.constraint(equalTo: leadingAnchor, constant: contentInset.left).isActive = true
    lblTitle.rightAnchor.constraint(equalTo: trailingAnchor, constant: contentInset.right).isActive = true
  }
  
  func setupTxtCode() {
    addSubview(txtCode)
    txtCode.translatesAutoresizingMaskIntoConstraints = false
    txtCode.topAnchor.constraint(equalTo: lblTitle.bottomAnchor, constant: contentElementsIndent).isActive = true
    txtNumber.bottomAnchor.constraint(equalTo: bottomAnchor, constant: contentInset.bottom).isActive = true
    txtCode.leadingAnchor.constraint(equalTo: lblTitle.leadingAnchor, constant: contentInset.left).isActive = true
  }
  
  func setupTxtNumber() {
    addSubview(txtNumber)
    txtNumber.translatesAutoresizingMaskIntoConstraints = false
    txtNumber.topAnchor.constraint(equalTo: txtCode.topAnchor).isActive = true
    txtNumber.bottomAnchor.constraint(equalTo: txtCode.bottomAnchor).isActive = true
    txtNumber.leftAnchor.constraint(equalTo: txtCode.trailingAnchor, constant: phoneElementsIndent).isActive = true
    txtNumber.trailingAnchor.constraint(equalTo: lblTitle.trailingAnchor, constant: contentInset.right).isActive = true
  }
  
  
  func configLblTitle() {
    lblTitle.font = titleFont
    lblTitle.textColor = titleColor
    lblTitle.textAlignment = .left
    lblTitle.text = title
  }
  
  func configTxtCode() {
    txtCode.font = textFont
    txtCode.textColor = textColor
    txtCode.textAlignment = .right
    txtCode.backgroundColor = .clear
  }
  
  func configTxtNumber() {
    txtCode.font = textFont
    txtCode.textColor = textColor
    txtCode.textAlignment = .left
    txtCode.backgroundColor = .clear
  }
  
}
