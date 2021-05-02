//
//  ScanVC.swift
//  Bitirme
//
//  Created by Başak Ertuğrul on 16.04.2021.
//

import UIKit

class ScanVC: UIViewController {

    @IBOutlet weak var scanButton: UIButton!
    @IBOutlet weak var barcode: UITextField!
    
    var barcodeNumber: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        scanButton.layer.cornerRadius = 5.0
    }
    
    @IBAction func scanButtonPressed(_ sender: Any) {
        self.barcodeNumber = barcode.text ?? "22"
        if barcodeNumber == "" {
            let gif = UIImage.gifImageWithName("scanError")
            let imageView = UIImageView(image: gif)
            imageView.frame = CGRect(x: -20, y: 385, width: 467.25, height: 350)
            view.addSubview(imageView)
            DispatchQueue.main.asyncAfter(deadline: .now() + 8) {
                imageView.removeFromSuperview()
            }
        }
        else{
            let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = mainStoryboard.instantiateViewController(withIdentifier: "productVC") as! ProductVC
            vc.modalPresentationStyle = .fullScreen
            vc.barcodeNumber = self.barcodeNumber
            present(vc, animated: true, completion: nil)
        }
    }

}
