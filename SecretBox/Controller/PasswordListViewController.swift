//
//  ViewController.swift
//  SecretBox
//
//  Created by José Victor Pereira Costa on 14/06/18.
//  Copyright © 2018 José Victor Pereira Costa. All rights reserved.
//

import UIKit

class PasswordListViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configStatusColor()
    }
    
    
    /// config status bar color
    func configStatusColor() {
        if navigationController != nil {
            navigationController!.navigationBar.barStyle = .blackOpaque
        }
    }
}

