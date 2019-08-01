//
//  NKPhoneNumber.swift
//  NKPhoneInputView
//
//  Created by Nick Kopilovskii on 7/31/19.
//

import Foundation

//MARK: - PhoneNumber
public struct NKPhoneNumber: Codable {
  static let cPhoneNumberLength = 12
  private static let cPlaceholderCodeLength = 3
  
  var code: CountryCode?
  var number: String?
  
  var stringValue: String? {
    guard let code = code else { return nil }
    return code.phoneCode + (number ?? "")
  }
  
  var numberLength: Int {
    guard let code = code else { return 0 }
    return NKPhoneNumber.cPhoneNumberLength - code.phoneCode.count
  }
  
  var codePlaceholder: String {
    return "+000"
  }
  
  var phonePlaceholder: String {
    var string = ""
    let maxLength = NKPhoneNumber.cPhoneNumberLength - (code?.phoneCode.count ?? NKPhoneNumber.cPlaceholderCodeLength)
    (0...maxLength).forEach { _ in
      string.append("0")
    }
    return string
  }
}

//MARK: - CountryCode
public extension NKPhoneNumber {
  struct CountryCode: Codable {
    let name: String
    let countryCode: String
    let phoneCode: String
    let flag: String
  }
}
