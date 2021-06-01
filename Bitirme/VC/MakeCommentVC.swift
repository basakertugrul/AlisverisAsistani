//
//  MakeCommentVC.swift
//  Bitirme
//
//  Created by Başak Ertuğrul on 16.04.2021.
//

import UIKit
import SwiftKeychainWrapper

class MakeCommentVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    
    @IBOutlet weak var anonymousButton: UIButton!
    @IBOutlet weak var nicknameButton: UIButton!
    @IBOutlet weak var anonymousLabel: UILabel!
    @IBOutlet weak var nicknameLabel: UILabel!
    let radioController: RadioButtonController = RadioButtonController()
    var anonymous : Bool = false
    
    var productID: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.commentTextField.delegate = self
        commentTextField.borderStyle = UITextField.BorderStyle.roundedRect
        commentTextField.attributedPlaceholder = NSAttributedString(string: "Feedback için teşekkür ederiz.",
                                                                    attributes: [NSAttributedString.Key.foregroundColor: UIColor.white,
                                                                                 NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20)])
        commentTextField.textAlignment = .left
        commentTextField.contentVerticalAlignment = .top
        sendButton.layer.cornerRadius = 0.05 * sendButton.bounds.size.width
        
        if KeychainWrapper.standard.string(forKey: "username") != nil {
            nicknameLabel.text = KeychainWrapper.standard.string(forKey: "username")
        }
        radioController.buttonsArray = [anonymousButton,nicknameButton]
        radioController.defaultButton = nicknameButton
        self.anonymous = false
    }
    
    @IBAction func anonymousButtonTapped(_ sender: UIButton) {
        radioController.buttonArrayUpdated(buttonSelected: sender)
        self.anonymous = true
    }
    
    @IBAction func nicknameButtonTapped(_ sender: UIButton) {
        radioController.buttonArrayUpdated(buttonSelected: sender)
        self.anonymous = false
    }
    
    @IBAction func sendButtonTapped(_ sender: UIButton) {
        let comment = commentTextField.text
        //self.anonymous
        var isAnonym:Int = 0
        if self.anonymous {
            isAnonym = 1
        }
        
        let params: [String: Any] = ["productId": String(self.productID),
                                     "comment": comment ?? "",
                                     "isAnonym": isAnonym]
        NetworkManager.sendCommentRequest(parameters: params)
        { [weak self] (data, error) in
            if let error = error {
                print("ERROR:\(error)")
                return
            }
            print(String(describing: data))
            self!.dismiss(animated: true, completion: nil)
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
