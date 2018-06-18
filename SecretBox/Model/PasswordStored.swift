//
//  PasswordStored.swift
//  SecretBox
//
//  Created by José Victor Pereira Costa on 18/06/18.
//  Copyright © 2018 José Victor Pereira Costa. All rights reserved.
//

import UIKit

class PasswordStored: Codable {
    
    private var logo: Data?
    var url: String = ""
    var user: String = ""
    var password: String = ""
    var index:Int = 0
    
    init() {
        self.logo = nil
        self.url = ""
        self.user = ""
        self.password = ""
        self.index = 0
    }
    
    init(fromString: String) {
        do {
            let data : Data = fromString.data(using: String.Encoding.utf8)!
            let object = try JSONDecoder().decode(PasswordStored.self, from: data)
            
            self.user = object.user
            self.password = object.password
            self.url = object.url
            self.logo = object.logo
            self.index = object.index
            
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
    
    func setLogo(image: UIImage) {
        logo = UIImagePNGRepresentation(image)!
    }
    
    func getLogo() -> UIImage {
        if let newLogo = logo {
            return UIImage(data: newLogo)!
        }
      
        return UIImage(named: "ic-logo-1")!
    }
    
}
