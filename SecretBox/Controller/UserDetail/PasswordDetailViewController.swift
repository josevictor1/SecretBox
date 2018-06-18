//
//  PasswordDetailViewController.swift
//  SecretBox
//
//  Created by José Victor Pereira Costa on 15/06/18.
//  Copyright © 2018 José Victor Pereira Costa. All rights reserved.
//

import UIKit

enum TextFields: Int {
    case name = 0, email, password
}

class PasswordDetailViewController: KeyboardAvoidance {

    @IBOutlet weak var imageShadowView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameTextField: JVMaterialText!
    @IBOutlet weak var emailTextField: JVMaterialText!
    @IBOutlet weak var passwordTextField: JVMaterialText!
    @IBOutlet weak var passwordShowHideButton: UIButton!
    @IBOutlet weak var editSaveButton: RoundedButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var obfuscatorButton: UIButton!
    @IBOutlet weak var copyButton: UIButton!
    
    
    var isEditingSaving = false
    var isObfuscated = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollViewDidScroll(scrollView: scrollView)
        setKeyboardToAvoid(scrollView: scrollView)
        nameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        nameTextField.tag = TextFields.name.rawValue
        emailTextField.tag = TextFields.email.rawValue
        passwordTextField.tag = TextFields.password.rawValue
        enableDisableEditing()
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView.contentOffset.x > 0 {
            scrollView.contentOffset.x = 0
        }
    }
    
    func updateEditSaveButton() {
        
        let themeColor = UIColor(red: 48/255, green: 116/255, blue: 149/255, alpha: 1)
        
        if isEditingSaving {
            editSaveButton.updateButtonOnClick(newTitle: "Salvar", textColor: .white, backGroundColor: themeColor)
        } else {
            editSaveButton.updateButtonOnClick(newTitle: "Editar", textColor: themeColor, backGroundColor: .white)
        }
    }
    
    func enableDisableEditing() {
        nameTextField.isEnabled = isEditingSaving
        emailTextField.isEnabled = isEditingSaving
        passwordTextField.isEnabled = isEditingSaving
    }
    
    @IBAction func showHidePassword(_ sender: Any) {
        
        if isObfuscated {
            if let image = UIImage(named: "ic-eye-filled") {
                obfuscatorButton.setImage(image, for: .normal)
            }
        } else {
            if let image = UIImage(named: "ic-eye-leaked") {
                obfuscatorButton.setImage(image, for: .normal)
            }
        }
        passwordTextField.isSecureTextEntry = !isObfuscated
        isObfuscated = !isObfuscated
    }
    
    @IBAction func copyPassword(_ sender: Any) {
        UIPasteboard.general.string = passwordTextField.text
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "ModalImageViewController"){
            let modal = segue.destination as! ModalImageViewController
            modal.delegate = self
        }
    }

    @IBAction func editSave(_ sender: Any) {
        isEditingSaving = !isEditingSaving
        updateEditSaveButton()
        enableDisableEditing()
        self.performSegue(withIdentifier: "ModalImageViewController", sender: self)
    }
    
}

extension PasswordDetailViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        
        return false
    }
}

extension PasswordDetailViewController: ModalImageViewControllerDelegate {
    func getStatePadLock(ModalImageViewControllerDelegate: ModalImageViewController) -> Bool {
        return isEditingSaving
    }
}

