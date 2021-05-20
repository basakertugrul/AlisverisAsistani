//
//  SignInVC.swift
//  Bitirme
//
//  Created by Başak Ertuğrul on 16.04.2021.
//

import UIKit
import SwiftKeychainWrapper

class SignInVC: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func signInButtonPressed(_ sender: Any) {
        let username = String(usernameTextField.text ?? "")
        let password = String(passwordTextField.text ?? "")
        let params: [String: Any] = ["username": username,
                                     "password": password]
        let signUrlStr = "http://192.168.1.155:62755/api/auth/login"
        NetworkManager.sendPostRequest(urlStr: signUrlStr,
                                       parameters: params)
        { [weak self] (data, error) in
            if let error = error {
                print("Sign In Error:\(error)")
                return
            }
            self!.userSignedIn(data: data, username: username, password: password)
        }
    }
    
    func userSignedIn(data: [String : Any]?, username: String, password:String )  {
        if let token = data!["token"] as? String{
            if let expiration = data!["expiration"] as? String{
                let saveSuccessfulToken: Bool = KeychainWrapper.standard.set(token, forKey: "token")
                let saveSuccessfulUsername: Bool = KeychainWrapper.standard.set(username, forKey: "username")
                let saveSuccessfulExpiration: Bool = KeychainWrapper.standard.set(expiration, forKey: "expiration")
                let saveSuccessfulPassword: Bool = KeychainWrapper.standard.set(password, forKey: "password")
            }
        }
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        vc.modalPresentationStyle = .fullScreen
        vc.backFromProfile = true
        present(vc, animated: true, completion: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        ProfileVC().viewWillAppear(true)
    }
}

