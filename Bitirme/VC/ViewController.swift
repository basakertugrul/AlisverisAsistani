//
//  ViewController.swift
//  Bitirme
//
//  Created by Başak Ertuğrul on 16.04.2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var scanView: UIView!
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        UserDefaults.standard.removeObject(forKey: "token")
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        scanView.alpha = 1
        profileView.alpha = 0
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(red: 0.957, green: 0.918, blue: 0.902, alpha: 1.0)], for: UIControl.State.selected)
        segmentedControl.selectedSegmentTintColor = UIColor(red: 0.184, green: 0.314, blue: 0.380, alpha: 1.0)
    }
    
    @IBAction func switchViews(_ sender: UISegmentedControl){
        
        if sender.selectedSegmentIndex == 0 {
            scanView.alpha = 1
            profileView.alpha = 0
        }
        
        else {
            if (UserDefaults.standard.string(forKey: "token") == nil) {
                let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = mainStoryboard.instantiateViewController(withIdentifier: "signInVC") as! SignInVC
                vc.modalPresentationStyle = .popover
                present(vc, animated: true, completion: nil)
            }
            scanView.alpha = 0
            profileView.alpha = 1
        }
    }
}

