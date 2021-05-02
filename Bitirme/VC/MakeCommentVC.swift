//
//  MakeCommentVC.swift
//  Bitirme
//
//  Created by Başak Ertuğrul on 16.04.2021.
//

import UIKit

class MakeCommentVC: UIViewController {
    
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    
    @IBOutlet weak var anonymousButton: UIButton!
    @IBOutlet weak var nicknameButton: UIButton!
    @IBOutlet weak var anonymousLabel: UILabel!
    @IBOutlet weak var nicknameLabel: UILabel!
    let radioController: RadioButtonController = RadioButtonController()
    var anonymous : Bool = false
    
    var barcodeNumber: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        commentTextField.borderStyle = UITextField.BorderStyle.roundedRect
        commentTextField.attributedPlaceholder = NSAttributedString(string: "Thank you for the feedback",
                                                                    attributes: [NSAttributedString.Key.foregroundColor: UIColor.white,
                                                                                 NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20)])
        commentTextField.textAlignment = .left
        commentTextField.contentVerticalAlignment = .top
        sendButton.layer.cornerRadius = 0.05 * sendButton.bounds.size.width
        
        if UserDefaults.standard.value(forKey: "Username") != nil {
            nicknameLabel.text = UserDefaults.standard.value(forKey: "Username") as? String
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
        //Servis
    }
    
}
