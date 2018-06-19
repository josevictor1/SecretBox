//
//  SecretBoxTests.swift
//  SecretBoxTests
//
//  Created by José Victor Pereira Costa on 14/06/18.
//  Copyright © 2018 José Victor Pereira Costa. All rights reserved.
//

import XCTest
@testable import SecretBox

class SecretBoxTests: XCTestCase {

    func testAddToPasswords() {
        let list = PasswordStoredList()
        
        let password = PasswordStored()
        password.user = "email"
        password.password = "password"
        password.url = "url"
        
        list.addToPasswords(value: password)
        
        var passwords = list.getPasswords()
        XCTAssertTrue(passwords[0].user == "email")
        XCTAssertTrue(passwords[0].password == "password")
        XCTAssertTrue(passwords[0].url == "url")
        XCTAssertTrue(passwords[0].index == 1)
    }
    
    func testDeleteFromPasswords() {
        var passwords = [PasswordStored]()
        
        var index = 0
        for _ in 0...5 {
            let password = PasswordStored()
            password.user = String(index)
            password.password = String(index)
            password.index = index
            password.url = String(index)
            
            passwords.append(password)
            index += 1
        }
        
        let list = PasswordStoredList()
        list.setPasswords(passwords)
        
        let passwordDeleted = PasswordStored()
        passwordDeleted.user = String(index)
        passwordDeleted.password = String(index)
        passwordDeleted.index = 3
        passwordDeleted.url = String(index)
        
        list.deleteFromPasswords(value: passwordDeleted)
        
        for item in list.getPasswords() {
            XCTAssertTrue(item.index != 3)
        }
        XCTAssertTrue(list.getPasswords().count == 5)
    }
    
    func testUpdateFromPasswords() {
        var passwords = [PasswordStored]()
        
        var index = 0
        for _ in 0...5 {
            let password = PasswordStored()
            password.user = String(index)
            password.password = String(index)
            password.index = index
            password.url = String(index)
            
            passwords.append(password)
            index += 1
        }
        
        let list = PasswordStoredList()
        list.setPasswords(passwords)
        
        let passwordNewValues = PasswordStored()
        passwordNewValues.user = "teste@teste.com"
        passwordNewValues.password = "passwordNew"
        passwordNewValues.index = 1
        passwordNewValues.url = "SecretBox"
        
        list.updateFromPasswords(newValue: passwordNewValues)
        let newValue = list.getPasswordWithIndex(Index: 1)
        XCTAssertTrue(newValue?.url == "SecretBox")
        XCTAssertTrue(newValue?.password == "passwordNew")
        XCTAssertTrue(newValue?.user == "teste@teste.com")
        XCTAssertTrue(newValue?.index == 1)
    }
    
    func testGetPasswordWithIndex() {
        var passwords = [PasswordStored]()
        
        var index = 0
        for _ in 0...5 {
            let password = PasswordStored()
            password.user = String(index)
            password.password = String(index)
            password.index = index
            password.url = String(index)
            
            passwords.append(password)
            index += 1
        }
        
        let list = PasswordStoredList()
        list.setPasswords(passwords)
        
        let newValue = list.getPasswordWithIndex(Index: 3)
        XCTAssertTrue(newValue?.url == "3")
        XCTAssertTrue(newValue?.password == "3")
        XCTAssertTrue(newValue?.user == "3")
        XCTAssertTrue(newValue?.index == 3)
    }
    
}
