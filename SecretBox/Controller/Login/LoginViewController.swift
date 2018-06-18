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
    
    
//    func doLogin(withPassword password: String) {
//        let service = LoginService()
//        startLoading()
//        service.login(user: userTextField.text!, password: password, withCompletionHandler: { afResponse in
//            self.stopLoading()
//            guard let response = afResponse.response else {
//                // erro inesperado
//                self.error(withMessage: "Ocorreu um erro inesperado, tente novamente mais tarde")
//                return
//            }
//            
//            if response.statusCode == 403 {
//                //tratar para email/senha incorreta
//                self.error(withMessage: "Email/Senha incorreto(s)")
//                return
//            }
//            else if response.statusCode == 400 {
//                //tratar para email invalido
//                self.error(withMessage: "Email inválido")
//                return
//            }
//            
//            if let json = afResponse.result.value {
//                if let dictionary = json as? [String: String] {
//                    UserInfoModel.authorizationToken = dictionary["token"]!
//                    UserInfoModel.loggedUser = self.userTextField.text!
//                    
//                    let user = UserInfoModel()
//                    user.user = self.userTextField.text!
//                    user.password = self.passwordTextField.text!
//                    
//                    if let savedInfo = Keychain.get(key: self.userTextField.text!) {
//                        let oldInfo = SavedPasswordListModel(fromString: savedInfo)
//                        user.haveTouchID = oldInfo.user.haveTouchID
//                        if user.password.isEmpty {
//                            user.password = oldInfo.user.password
//                        }
//                        oldInfo.user = user
//                        
//                        Keychain.set(key: self.userTextField.text!, value: oldInfo.toString())
//                    }
//                    else {
//                        let savedInfo = SavedPasswordListModel()
//                        savedInfo.user = user
//                        savedInfo.setPasswords([SavedPasswordModel]())
//                        
//                        Keychain.set(key: self.userTextField.text!, value: savedInfo.toString())
//                    }
//                    
//                    self.dismiss(animated: true, completion: nil)
//                }
//            }
//        })
//    }
//    
//    
//    
//    
//    
//    
//    func getTouchID(forUser user: User) {
//        let myContext = LAContext()
//        let myLocalizedReasonString = "Use para logar novamente"
//        
//        var authError: NSError?
//        if #available(iOS 8.0, *) {
//            if myContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authError) {
//                myContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: myLocalizedReasonString) { success, evaluateError in
//                    if success {
//                        self.setUserDefaults()
//                        self.doLogin(withPassword: user.password)
//                    } else {
//                        DispatchQueue.main.async {
//                            self.passwordTextField.becomeFirstResponder()
//                            self.passwordTextField.isHidden = false
//                            self.passwordBottomView.isHidden = false
//                        }
//                    }
//                }
//            }
//        }
//    }
//    
//    
//    func setUserDefaults() {
//        DispatchQueue.main.async {
//            if self.keepConnected.isOn {
//                let keepConnected: String = self.userTextField.text ?? ""
//                UserDefaults.standard.set(keepConnected, forKey: "keepConnected")
//            } else {
//                UserDefaults.standard.set("", forKey: "keepConnected")
//            }
//        }
//    }
//    
//    @IBAction func loginButtonTouchUpInside(_ sender: RoundedButton) {
//        setUserDefaults()
//        doLogin(withPassword: passwordTextField.text!)
//    }
//    
//    
//    
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


