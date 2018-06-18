//
//  SBRepository.swift
//  SecretBox
//
//  Created by José Victor Pereira Costa on 18/06/18.
//  Copyright © 2018 José Victor Pereira Costa. All rights reserved.
//

import Foundation

import UIKit
import Alamofire
import Moya

class SBRepository: Repository {
    
    func postLogin(email: String, password: String, withCompletionHandler: @escaping (_ response: DataResponse<Any>) -> Void){
        let parameters: Parameters = [
            "email": email,
            "password": password
        ]
        
        let headers: HTTPHeaders = [
            "content-type": "application/json"
        ]
        
        Alamofire.request("https://dev.people.com.ai/mobile/api/v2/login", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { response in
            withCompletionHandler(response)
        })
    }
    
    func postRegister(email: String, password: String, name: String, withCompletionHandler: @escaping (_ response: DataResponse<Any>) -> Void){
        
        let parameters: Parameters = [
            "email": email,
            "name": name,
            "password": password
        ]
        
        let headers: HTTPHeaders = [
            "content-type": "application/json"
        ]
        
        Alamofire.request("https://dev.people.com.ai/mobile/api/v2/register", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { response in
            withCompletionHandler(response)
        })
    }
    
    func getLogo(forUrl:String, withCompletionHandler: @escaping (_ image: UIImage) -> Void) {
        let auth = User.authorizationToken
        let headers: HTTPHeaders = [
            "Authorization": auth
        ]
        
        Alamofire.request("https://dev.people.com.ai/mobile/api/v2/logo/\(forUrl)", headers: headers).responseData { response in
            if let data = response.result.value {
                if let image = UIImage(data: data) {
                    withCompletionHandler(image)
                }
            }
        }
    }
}
