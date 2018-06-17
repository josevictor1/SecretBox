//
//  LoginViewController.swift
//  SecretBox
//
//  Created by José Victor Pereira Costa on 14/06/18.
//  Copyright © 2018 José Victor Pereira Costa. All rights reserved.
//

import UIKit

class LoginViewController: KeyboardAvoidance {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageLogin: UIImageView!
    @IBOutlet weak var emailField: JVMaterialText!
    @IBOutlet weak var passwordField: JVMaterialText!
    @IBOutlet weak var rememberMe: RoundedButton!
    @IBOutlet weak var button: RoundedButton!
    
    var rememberUserLogin = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setKeyboardToAvoid(scrollView: scrollView)
        emailField.delegate = self
        passwordField.delegate = self
        emailField.tag = 0
        passwordField.tag = 1
    }
    
    @IBAction func rememberUser(_ sender: Any) {
        rememberUserLogin = !rememberUserLogin
        updateRemberMeButton()
    }
    
    func updateRemberMeButton() {
        
        let themeColor = UIColor(red: 48/255, green: 116/255, blue: 149/255, alpha: 1)
        
        if rememberUserLogin {
            rememberMe.updateButtonOnClick(textColor: .white, backGroundColor: themeColor)
        } else {
            rememberMe.updateButtonOnClick(textColor: themeColor, backGroundColor: .white)
        }
    }
    
    @IBAction func login(_ sender: Any) {
    
    }
}


extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        
        return false
    }
}


