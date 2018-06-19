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
}
