//
//  PasswordDetailViewController.swift
//  SecretBox
//
//  Created by José Victor Pereira Costa on 15/06/18.
//  Copyright © 2018 José Victor Pereira Costa. All rights reserved.
//

import UIKit

class PasswordDetailViewController: UIViewController {

    @IBOutlet weak var imageShadowView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameTextField: JVMaterialText!
    @IBOutlet weak var emailTextField: JVMaterialText!
    @IBOutlet weak var passwordTextField: JVMaterialText!
    @IBOutlet weak var passwordShowHideButton: UIButton!
    @IBOutlet weak var editSaveButton: RoundedButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func showHidePassword(_ sender: Any) {
    
    }
    
    @IBAction func copyPassword(_ sender: Any) {
        
    }
    
    @IBAction func editSave(_ sender: Any) {
        
    }
    
}
