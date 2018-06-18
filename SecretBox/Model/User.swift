//
//  User.swift
//  SecretBox
//
//  Created by José Victor Pereira Costa on 18/06/18.
//  Copyright © 2018 José Victor Pereira Costa. All rights reserved.
//

import UIKit

class User: Codable {
    
    static var authorizationToken = ""
    static var loggedUser: String = ""
    
    var user: String = ""
    var password: String = ""
    var haveTouchID:Bool?
    
    init() {
        self.user = ""
        self.password = ""
    }
    
    init(fromString: String) {
        do {
            let data : Data = fromString.data(using: String.Encoding.utf8)!
            let object = try JSONDecoder().decode(User.self, from: data)
            user = object.user
            password = object.password
            haveTouchID = object.haveTouchID
        } catch let error as NSError {
            print(error)
        }
    }
    
    func toString() -> String {
        var convertedObject = ""
        do {
            let jsonData = try JSONEncoder().encode(self)
            convertedObject = String(data:jsonData, encoding:.utf8)!
        } catch let error as NSError {
            print(error)
        }
        
        return convertedObject
    }
    
}
