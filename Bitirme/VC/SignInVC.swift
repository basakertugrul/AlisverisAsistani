//
//  SignInVC.swift
//  Bitirme
//
//  Created by Başak Ertuğrul on 16.04.2021.
//

import UIKit

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
            self!.userSignedIn(data: data, username: username)
        }
    }
    
    func userSignedIn(data: [String : Any]?, username: String)  {
        
        let token = data!["token"]
        
        UserDefaults.standard.setValue(token, forKey: "token")
        UserDefaults.standard.setValue(username, forKey: "Username")
        
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        ProfileVC().viewWillAppear(true)
    }
}

