//
//  RegisterVC.swift
//  Bitirme
//
//  Created by Başak Ertuğrul on 16.04.2021.
//

import UIKit
import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

class RegisterVC: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func registerButtonPressed(_ sender: Any) {
        let username = String(usernameTextField.text ?? "")
        let password = String(passwordTextField.text ?? "")
        let email = String(emailTextField.text ?? "")
        
        let params: [String: Any] = ["username": username,
                                     "password": password,
                                     "email": email]
        
        let signUrlStr = "http://192.168.1.155:62755/api/auth/register"
        
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
        let expiration = data!["expiration"]
        
        UserDefaults.standard.setValue(token, forKey: "token")
        UserDefaults.standard.setValue(username, forKey: "username")
        UserDefaults.standard.setValue(expiration, forKey: "expiration")
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        vc.modalPresentationStyle = .fullScreen
//        vc.barcodeNumber = self.barcodeNumber
        present(vc, animated: true, completion: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        ProfileVC().viewWillAppear(true)
    }
}


//SIGNOUTTA UserDefaults.standard.remove(token, forKey: "token") UserDefaults.standard.remove(username, forKey: "username") UserDefaults.standard.remove(expiration, forKey: "expiration")

//Basak98A.b
//Basakk
