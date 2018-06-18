//
//  PasswordStorredList.swift
//  SecretBox
//
//  Created by José Victor Pereira Costa on 18/06/18.
//  Copyright © 2018 José Victor Pereira Costa. All rights reserved.
//
import UIKit

class PasswordStoredList: Codable {
    
    private var passwords = [PasswordStored]()
    var user = User()
    private var maxIndex: Int = 0
    
    init() {
        self.passwords = [PasswordStored]()
        self.user = User()
        self.maxIndex = 0
    }
    
    init(fromString: String) {
        do {
            let data : Data = fromString.data(using: String.Encoding.utf8)!
            let object = try JSONDecoder().decode(PasswordStoredList.self, from: data)
            
            self.user = object.user
            self.passwords = object.passwords
            self.maxIndex = object.maxIndex
        } catch let error as NSError {
            print(error)
        }
    }
    
    func toString() -> String {
        var result = ""
        do {
            let jsonData = try JSONEncoder().encode(self)
            result = String(data:jsonData, encoding:.utf8)!
        } catch let error as NSError {
            print(error)
        }
        
        return result
    }
    
    func setPasswords(_ newPasswords:[PasswordStored] ) {
        self.passwords = newPasswords
    }
    
    func getPasswords() -> [PasswordStored] {
        return self.passwords
    }
    
    func addToPasswords(value: PasswordStored) {
        maxIndex += 1
        value.index = self.maxIndex
        passwords.append(value)
    }
    
    func deleteFromPasswords(value: PasswordStored) {
        var index = 0
        for password in passwords {
            if password.index == value.index {
                passwords.remove(at: index)
            }
            index += 1
        }
    }
    
    func updateFromPasswords(newValue: PasswordStored) {
        var index = 0
        for password in passwords {
            if password.index == newValue.index {
                passwords[index] = newValue
            }
            index += 1
        }
    }
    
    func getPasswordWithIndex(Index index: Int) -> PasswordStored? {
        for password in passwords {
            if password.index == index {
                return password
            }
        }
        return nil
    }
    

}
