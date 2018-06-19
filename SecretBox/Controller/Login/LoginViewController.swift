//
//  LoginViewController.swift
//  SecretBox
//
//  Created by José Victor Pereira Costa on 14/06/18.
//  Copyright © 2018 José Victor Pereira Costa. All rights reserved.
//

import UIKit
import LocalAuthentication

enum TextFieldLogin: Int {
    case email = 0, password
}

enum ErrorNumbers: Int {
    case forbidden = 403
    case badRequest = 400
}

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
        emailField.tag = TextFieldLogin.email.rawValue
        passwordField.tag = TextFieldLogin.password.rawValue
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
    
    func showAlert(alert: String) {
        
        let alert = UIAlertController(title: "", message: alert, preferredStyle: .alert)
        
        self.present(alert, animated: true, completion: nil)
        
        let when = DispatchTime.now() + 1
        
        DispatchQueue.main.asyncAfter(deadline: when) {
            alert.dismiss(animated: true, completion: nil)
        }
    }
    
    
    func login(withPassword password: String) {
        
        let service = SBRepository()
        
        guard let email = emailField.text, let password = passwordField.text else {
            return
        }
        
        service.postLogin(email: emailField.text!, password: password, withCompletionHandler: { afResponse in
            guard let response = afResponse.response else {
                self.showAlert(alert: "Serviço indisponível, tente novamente mais tarde!")
                return
            }
            
            if response.statusCode == ErrorNumbers.forbidden.rawValue || response.statusCode == ErrorNumbers.badRequest.rawValue {
                self.showAlert(alert: "Email ou senha incorreto(s)")
                return
            }
            
            if let json = afResponse.result.value {
                if let dictionary = json as? [String: String] {
                    User.authorizationToken = dictionary["token"]!
                    User.loggedUser = email
                    
                    let user = User()
                    user.user = email
                    user.password = password
                    
                    if let savedInfo = Keychain.get(key: email) {
                        let oldInfo = PasswordStoredList(fromString: savedInfo)
                        user.haveTouchID = oldInfo.user.haveTouchID
                        if user.password.isEmpty {
                            user.password = oldInfo.user.password
                        }
                        oldInfo.user = user
                        
                        Keychain.set(key: email, value: oldInfo.toString())
                    }
                    else {
                        let savedInfo = PasswordStoredList()
                        savedInfo.user = user
                        savedInfo.setPasswords([PasswordStored]())
                        
                        Keychain.set(key: email, value: savedInfo.toString())
                    }
                    self.dismiss(animated: true, completion: nil)
                }
            }
        })
    }

    func setUserDefaults() {
        DispatchQueue.main.async {
            if self.rememberUserLogin {
                let keepConnected: String = self.emailField.text ?? ""
                UserDefaults.standard.set(keepConnected, forKey: "keepConnected")
            } else {
                UserDefaults.standard.set("", forKey: "keepConnected")
            }
        }
    }
    
    func getTouchID(forUser user: User) {
        let myContext = LAContext()
        let myLocalizedReasonString = "Use para logar novamente"
        
        var authError: NSError?
        if #available(iOS 8.0, *) {
            if myContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authError) {
                myContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: myLocalizedReasonString) { success, evaluateError in
                    if success {
                        self.setUserDefaults()
                        self.login(withPassword: user.password)
                    } else {
                        DispatchQueue.main.async {
                            
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func login(_ sender: Any) {
        setUserDefaults()
        login(withPassword: passwordField.text!)
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


