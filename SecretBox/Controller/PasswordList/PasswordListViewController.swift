//
//  ViewController.swift
//  SecretBox
//
//  Created by José Victor Pereira Costa on 14/06/18.
//  Copyright © 2018 José Victor Pereira Costa. All rights reserved.
//

import UIKit
import Alamofire
import LocalAuthentication

class PasswordListViewController: UITableViewController {

    var passwordStoredList = [PasswordStored]()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setLoggedUser()
        getTouchID()
        automaticLogin()
        configStatusColor()
        registerNib()
        tableView.separatorInset = .zero
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    @IBAction func logout(_ sender: Any) {
        performeToLogin()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setLoggedUser()
        getTouchID()
        updateTableView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PasswordDetailViewControllerSegue" {
            if let passwordDetail = segue.destination as? PasswordDetailViewController {
                passwordDetail.detailedObject = passwordStoredList[(tableView.indexPathForSelectedRow?.row)!]
                passwordDetail.delegate = self
            }
        }
        else if segue.identifier == "PasswordRegisterViewControllerSegue" {
            if let passwordRegister = segue.destination as? PasswordRegisterViewController{
                passwordRegister.delegate = self
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return passwordStoredList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserInfoCell") as? UserInfoCell else {
            fatalError("The dequeued cell is not an instance of UserInfoCell")
        }
        cell.titleText.text = passwordStoredList[indexPath.row].url
        cell.descText.text = passwordStoredList[indexPath.row].user
        cell.imageCell.image = passwordStoredList[indexPath.row].getLogo()
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteData(data: passwordStoredList[indexPath.row])
            updateTableView()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "PasswordDetailViewControllerSegue", sender: self)
    }
    
    func deleteData(data: PasswordStored ) {
        guard let savedInfoString = Keychain.get(key: User.loggedUser) else { return }
        
        let oldInfo = PasswordStoredList(fromString: savedInfoString)
        
        oldInfo.deleteFromPasswords(value: data)
        
        Keychain.set(key: User.loggedUser, value: oldInfo.toString())
    }
    
    /// config status bar color
    func configStatusColor() {
        if navigationController != nil {
            navigationController!.navigationBar.barStyle = .blackOpaque
        }
    }
    
    func registerNib() {
        tableView.register(UINib(nibName: "UserInfoCell", bundle: nil), forCellReuseIdentifier: "UserInfoCell")
    }
    
    private func setLoggedUser() {
        let automaticLogin = UserDefaults.standard.string(forKey: "keepConnected")
        guard let automaticUser = automaticLogin else {
            return
        }
        if automaticUser.count > 0 {
            User.loggedUser = automaticUser
        }
    }
    
    func performeToLogin() {
        UserDefaults.standard.set("", forKey: "keepConnected")
        performSegue(withIdentifier: "LoginViewControllerSegue", sender: nil)
    }
    
    
    func getTouchID() {
        let myContext = LAContext()
        let myLocalizedReasonString = "Por favor, cadastre sua digital!"
        
        guard let storedData = Keychain.get(key: User.loggedUser) else {
            return
        }
        let savedInfo = PasswordStoredList(fromString: storedData)
        let touch = savedInfo.user.haveTouchID
        
        if touch == nil {
            var authError: NSError?
            if #available(iOS 8.0, *) {
                if myContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authError) {
                    myContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: myLocalizedReasonString) { success, evaluateError in
                        if success {
                            savedInfo.user.haveTouchID = true
                        } else {
                            savedInfo.user.haveTouchID = false
                        }
                        Keychain.set(key: savedInfo.user.user, value: savedInfo.toString())
                    }
                }
            }
        }
    }

    func automaticLogin() {
        
        let automaticLogin = UserDefaults.standard.string(forKey: "keepConnected")
        
        guard let automaticUser = automaticLogin else {
            performeToLogin()
            return
        }
        
        if automaticUser.count > 0 {
            
            guard let userString = Keychain.get(key: automaticUser) else {
                return
            }
            
            let savedPassword = PasswordStoredList(fromString: userString)
            let userInfo = savedPassword.user
            let service = SBRepository()
            
            service.postLogin(email: userInfo.user, password: userInfo.password, withCompletionHandler: { response in
                if let json = response.result.value {
                    if let dictionary = json as? [String: String] {
                        User.authorizationToken = dictionary["token"]!
                        self.updateTableView()
                    }
                }
            })
            
        } else {
            performeToLogin()
        }
    }

    func updateTableView() {
        getStoredData()
        tableView.reloadData()
    }

    func getStoredData() {
        if let savedInfoData = Keychain.get(key: User.loggedUser) {
            let savedInfo = PasswordStoredList(fromString: savedInfoData)
            passwordStoredList = savedInfo.getPasswords()
        }
    }
}

extension PasswordListViewController: PasswordDetailViewControllerDelegate {
    func saveEditions(passwordDetailViewControllerDelegate: PasswordDetailViewControllerDelegate, index: Int, passwordStored: PasswordStored) {
        return
    }
}

extension PasswordListViewController: PasswordRegisterViewControllerDelegate{
    func ragisterPassword(passwordRegisterViewController: PasswordRegisterViewController, passwordStored: PasswordStored) {
        
        guard let savedInfoString = Keychain.get(key: User.loggedUser) else { return }
        
        let recived = passwordStored
        let oldInfo = PasswordStoredList(fromString: savedInfoString)
        let service = SBRepository()
        
        service.getLogo(forUrl: recived.url, withCompletionHandler: { image in
            var siteImage: UIImage
            let fisrt = UIImagePNGRepresentation(image);
            let second = UIImagePNGRepresentation(UIImage(named: "logo-1")!);
            if fisrt == second {
                siteImage = UIImage(named: "logo-1")!
            } else {
                siteImage = image
            }
            
            recived.setLogo(image: siteImage)
            oldInfo.addToPasswords(value: recived)
            
            Keychain.set(key: User.loggedUser, value: oldInfo.toString())
            self.updateTableView()
        })
    }
}
