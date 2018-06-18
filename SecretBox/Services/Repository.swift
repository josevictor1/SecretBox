//
//  Repository.swift
//  SecretBox
//
//  Created by José Victor Pereira Costa on 18/06/18.
//  Copyright © 2018 José Victor Pereira Costa. All rights reserved.
//

import UIKit
import Alamofire
import Moya

protocol Repository {
    func postLogin(email: String, password: String, withCompletionHandler: @escaping (_ response: DataResponse<Any>) -> Void)
    func postRegister(email: String, password: String, name: String, withCompletionHandler: @escaping (_ response: DataResponse<Any>) -> Void)
    func getLogo(forUrl:String, withCompletionHandler: @escaping (_ image: UIImage) -> Void)
}
