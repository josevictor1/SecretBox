//
//  PasswordRegisterViewController.swift
//  SecretBox
//
//  Created by José Victor Pereira Costa on 15/06/18.
//  Copyright © 2018 José Victor Pereira Costa. All rights reserved.
//

import UIKit

protocol PasswordRegisterViewControllerDelegate: class {
    func ragisterPassword(passwordRegisterViewController: PasswordRegisterViewControllerDelegate, passwordStored: PasswordStored)
}

class PasswordRegisterViewController: KeyboardAvoidance {

    @IBOutlet weak var nameTextField: JVMaterialText!
    @IBOutlet weak var emailTextField: JVMaterialText!
    @IBOutlet weak var passwordTextField: JVMaterialText!
    @IBOutlet weak var scrollView: UIScrollView!
    
    weak var delegate: PasswordRegisterViewControllerDelegate?
    var passwordStored = PasswordStored()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setKeyboardToAvoid(scrollView: scrollView)
        nameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        nameTextField.tag = TextFields.name.rawValue
        emailTextField.tag = TextFields.email.rawValue
        passwordTextField.tag = TextFields.password.rawValue
    }

    @IBAction func register(_ sender: Any) {
        guard let email = emailTextField.text, let site = nameTextField.text, let password = passwordTextField.text  else {
            return
        }
        let passwordStored = PasswordStored()
        passwordStored.
        
        if let passwordListDelegate = delegate {
            passwordListDelegate.ragisterPassword(passwordRegisterViewController: self, passwordStored: <#T##PasswordStored#>)
        }
    }
}

extension PasswordRegisterViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return false
    }
}



