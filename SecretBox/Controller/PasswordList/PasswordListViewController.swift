//
//  ViewController.swift
//  SecretBox
//
//  Created by José Victor Pereira Costa on 14/06/18.
//  Copyright © 2018 José Victor Pereira Costa. All rights reserved.
//

import UIKit


import UIKit
import Alamofire
import LocalAuthentication

class PasswordListViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configStatusColor()
        //getTouchID()
    }
    
    
    /// config status bar color
    func configStatusColor() {
        if navigationController != nil {
            navigationController!.navigationBar.barStyle = .blackOpaque
        }
    }
    
//    private func setLoggedUser() {
//        let automaticLogin = UserDefaults.standard.string(forKey: "keepConnected")
//        guard let automaticUser = automaticLogin else {
//            return
//        }
//        if automaticUser.count > 0 {
//            User.loggedUser = automaticUser
//        }
//    }
    
//    func automaticLogin() {
//        let automaticLogin = UserDefaults.standard.string(forKey: "keepConnected")
//        guard let automaticUser = automaticLogin else {
//            goToLogin()
//            return
//        }
//        if automaticUser.count > 0 {
//            guard let userString = Keychain.get(key: automaticUser) else { return }
//            let savedPassword = SavedPasswordListModel(fromString: userString)
//            let userInfo = savedPassword.user
//
//            let service = LoginService()
//            service.login(user: userInfo.user, password: userInfo.password, withCompletionHandler: { afResponse in
//                self.stopLoading()
//
//                guard let response = afResponse.response else {
//                    // erro inesperado
//                    return
//                }
//
//                if response.statusCode != 201 {
//                    //tratar para email/senha incorreta
//                    return
//                }
//
//                if let json = afResponse.result.value {
//                    if let dictionary = json as? [String: String] {
//                        User.authorizationToken = dictionary["token"]!
//                        self.reloadTableView()
//                    }
//                }
//            })
//
//        }
//        else {
//            goToLogin()
//        }
//    }
//
//    func reloadTableView() {
//        getSavedPassword()
//        tableView.reloadData()
//    }
//
//    func getSavedPassword() {
//        if let savedInfoData = Keychain.get(key: User.loggedUser) {
//            let savedInfo = PasswordStoredList(fromString: savedInfoData)
//            list = savedInfo.getPasswords()
//        }
//    }
//
//    func goToLogin() {
//        UserDefaults.standard.set("", forKey: "keepConnected")
//        performSegue(withIdentifier: "loginSegue", sender: nil)
//    }
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "showPasswordDetailSegue" {
//            if let destinationVC = segue.destination as? PasswordDetailViewController{
//                destinationVC.model = list[(tableView.indexPathForSelectedRow?.row)!]
//                destinationVC.delegate = self
//            }
//        }
//        else if segue.identifier == "addPasswordSegue" {
//            if let destinationVC = segue.destination as? PasswordRegisterViewController{
//                destinationVC.delegate = self
//                destinationVC.transitioningDelegate = self
//            }
//        }
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        setLoggedUser()
//        getTouchID()
//        reloadTableView()
//    }
//
//    func getTouchID() {
//        let myContext = LAContext()
//        let myLocalizedReasonString = "Por favor, cadastre sua digital!"
//
//        guard let storedData = Keychain.get(key: User.loggedUser) else {
//            return
//        }
//        let savedInfo = PasswordStoredList(fromString: storedData)
//        let touch = savedInfo.user.haveTouchID
//
//        if touch == nil {
//            var authError: NSError?
//            if #available(iOS 8.0, *) {
//                if myContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authError) {
//                    myContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: myLocalizedReasonString) { success, evaluateError in
//                        if success {
//                            savedInfo.user.haveTouchID = true
//                        } else {
//                            savedInfo.user.haveTouchID = false
//                        }
//                        Keychain.set(key: savedInfo.user.user, value: savedInfo.toString())
//                    }
//                }
//            }
//        }
//    }
}

