//
//  ViewController.swift
//  Bitirme
//
//  Created by Başak Ertuğrul on 16.04.2021.
//

import UIKit
import SwiftKeychainWrapper

class ViewController: UIViewController {
    
    @IBOutlet weak var scanView: UIView!
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    var backFromProfile = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if KeychainWrapper.standard.string(forKey: "username") != nil {
            
            let username = String(KeychainWrapper.standard.string(forKey: "username")!)
            let password = String(KeychainWrapper.standard.string(forKey: "password")!)
            
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
             
        
        
        if self.backFromProfile == false{
            self.scanView.alpha = 1
            self.profileView.alpha = 0
        }
        else{
            self.scanView.alpha = 0
            self.profileView.alpha = 1
            segmentedControl.selectedSegmentIndex = 1
            self.backFromProfile = false
        }
        
        
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(red: 0.957, green: 0.918, blue: 0.902, alpha: 1.0)], for: UIControl.State.selected)
        segmentedControl.selectedSegmentTintColor = UIColor(red: 0.184, green: 0.314, blue: 0.380, alpha: 1.0)
    }
    
    @IBAction func switchViews(_ sender: UISegmentedControl){
        if sender.selectedSegmentIndex == 0 {
            scanView.alpha = 1
            profileView.alpha = 0
        }
        else {
            scanView.alpha = 0
            profileView.alpha = 1
        }
    }
    
    
    
    func userSignedIn(data: [String : Any]?, username: String, password: String)  {
        if let token = data!["token"] as? String{
            if let expiration = data!["expiration"] as? String{
                let _: Bool = KeychainWrapper.standard.set(String(token), forKey: "token")
                let _: Bool = KeychainWrapper.standard.set(String(username), forKey: "username")
                let _: Bool = KeychainWrapper.standard.set(String(expiration), forKey: "expiration")
                let _: Bool = KeychainWrapper.standard.set(String(password), forKey: "password")
            }
        }
        
        
    }

}
