//
//  UserRegisterViewController.swift
//  SecretBox
//
//  Created by José Victor Pereira Costa on 14/06/18.
//  Copyright © 2018 José Victor Pereira Costa. All rights reserved.
//

import UIKit

class UserRegisterViewController: KeyboardAvoidance {
    
    @IBOutlet weak var nameTextField: JVMaterialText!
    @IBOutlet weak var emailTextField: JVMaterialText!
    @IBOutlet weak var passwordTextField: JVMaterialText!
    @IBOutlet weak var titlePasswordDetails: UILabel!
    @IBOutlet weak var passwordDetaisText: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    var emailValid = false
    var passwordValid = false
    var nameValid = false
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setKeyboardToAvoid(scrollView: scrollView)
        nameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        nameTextField.tag = TextFields.name.rawValue
        emailTextField.tag = TextFields.email.rawValue
        passwordTextField.tag = TextFields.password.rawValue
        setPasswordDetailsText()
    }
    
    func setPasswordDetailsText(){
        titlePasswordDetails.text = "A senha deve possuir:"
        passwordDetaisText.text = " • mínimo 8 caracteres \n • 1 letra \n • 1 número \n • 1 caractere especial \n"
    }
    
    func register() {
        
        let name = nameTextField.text!
        let email = nameTextField.text!
        let password = passwordTextField.text!
        
        let service = SBRepository()
        service.postRegister(user: email, password: password, name: name) { afResponse in
            guard let response = afResponse.response else {
                // erro inesperado
                //                self.error(withMessage: "Ocorreu um erro inesperado, tente novamente mais tarde")
                return
            }
            
            if response.statusCode == 409 {
                self.handleServiceError(message: "Email já cadastrado")
                return
            }
            else if response.statusCode == 400 {
                self.handleServiceError(message: "Email inválido")
                return
            }
            
            if let json = afResponse.result.value {
                if let dictionary = json as? [String: String] {
                    User.authorizationToken = dictionary["token"]!
                    User.loggedUser = email
                    
                    let user = User()
                    user.user = email
                    user.password = password
                    
                    let savedInfo = PasswordStoredList()
                    savedInfo.user = user
                    savedInfo.setPasswords([PasswordStored]())
                    
                    Keychain.set(key: email, value: savedInfo.toString())
                    UserDefaults.standard.set(email, forKey: "keepConnected")
                    
                    self.handleServiceError(message: "sucessagem")
                    self.goToList()
                }
            }
        }
    }
    
    func handleServiceError(message: String) {
        titlePasswordDetails.text = message
        passwordDetaisText.text = ""
        
    }
    
    func goToList(){
        let registerViewController = self.storyboard?.instantiateViewController(withIdentifier: "PasswordListViewController") as! PasswordListViewController
        self.present(registerViewController, animated: true)
    }
    
    @IBAction func registerPassword(_ sender: Any) {
        if emailValid && passwordValid && nameValid {
            register()
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func backToLogin(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension UserRegisterViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return false
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let nsString = textField.text as NSString?
        
        if textField.tag == TextFields.password.rawValue {
            if let current = nsString?.replacingCharacters(in: range, with: string), string != "" {
                if current.count < 8 {
                    passwordTextField.hasError = true
                    passwordTextField.errorMessage = "número de caracteres menores que 8"
                } else if !current.verify(selectedType: CharacterSet.decimalDigits) {
                    passwordTextField.hasError = true
                    passwordTextField.errorMessage = "SENHA INVALIDA FALTA: 1 número"
                } else if !current.verify(selectedType: CharacterSet.alphanumerics.inverted) {
                    passwordTextField.hasError = true
                    passwordTextField.errorMessage = "SENHA INVALIDA FALTA: 1 caractere especial"
                } else if !current.verify(selectedType: CharacterSet.letters) {
                    passwordTextField.hasError = true
                    passwordTextField.errorMessage = "SENHA INVALIDA FALTA: 1 letra"
                } else {
                    passwordTextField.floatingPlaceHolder = "SENHA"
                    passwordTextField.hasError = false
                    passwordValid = true
                }
            }
            
        } else if textField.tag == TextFields.email.rawValue {
            if let current = nsString?.replacingCharacters(in: range, with: string) {
                emailValid = !current.isEmpty
            }
        } else if textField.tag == TextFields.name.rawValue {
            if let current = nsString?.replacingCharacters(in: range, with: string) {
                nameValid = !current.isEmpty
            }
        }
        
        return true
    }
}