//
//  StringExtension.swift
//  SecretBox
//
//  Created by José Victor Pereira Costa on 17/06/18.
//  Copyright © 2018 José Victor Pereira Costa. All rights reserved.
//

import Foundation

enum VerificationDataType {
    case decimalDigits, lowerCaseLetters, specialCharacters, upperCaseLetters
}

extension String {
    
    func isValidData(regex: String) -> Bool {
        if regex != "" && !isEmpty {
            let testRegex = NSPredicate(format:"SELF MATCHES %@", regex)
            return testRegex.evaluate(with: self)
        }
        return true
    }
    
    func verifyEmail() -> Bool {
        let regexMail = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return isValidData(regex: regexMail)
    }
    
    func verify(selectedType: CharacterSet) -> Bool {
        let data = self.rangeOfCharacter(from: selectedType)
        return data == nil ? false : true
    }

//    if let name = nameCell.input.text {
//        isValidName = name.count > 0
//        nameCell.errorMessage.isHidden = isValidName
//    }
//    if let email = emailCell.input.text {
//        isValidEmail = email.count > 0
//        emailCell.errorMessage.isHidden = isValidEmail
//    }
//    if let password = passwordCell.input.text {
//        let number = password.rangeOfCharacter(from: CharacterSet.decimalDigits)
//        let lowercaseLetter = password.rangeOfCharacter(from: CharacterSet.lowercaseLetters)
//        let special = password.rangeOfCharacter(from: CharacterSet.alphanumerics.inverted)
//        let upperCase = password.rangeOfCharacter(from: CharacterSet.uppercaseLetters)
//
//        isValidPassword = password.count >= 10
//        isValidPassword = isValidPassword && (number != nil ? true : false)
//        isValidPassword = isValidPassword && (lowercaseLetter != nil ? true : false)
//        isValidPassword = isValidPassword && (special != nil ? true : false)
//        isValidPassword = isValidPassword && (upperCase != nil ? true : false)
//    }
    
}
