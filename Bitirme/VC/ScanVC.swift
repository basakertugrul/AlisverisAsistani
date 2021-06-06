//
//  ScanVC.swift
//  Bitirme
//
//  Created by Başak Ertuğrul on 16.04.2021.
//

import UIKit
import MTBBarcodeScanner

class ScanVC: UIViewController {

    @IBOutlet weak var scanButton: UIButton!
    var barcodeNumber: String = ""
    
    @IBOutlet var previewView: UIView!
        var scanner: MTBBarcodeScanner?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        scanButton.layer.cornerRadius = 5.0
        scanner = MTBBarcodeScanner(previewView: previewView)
               // Alternatively, limit the type of codes you can scan:
        scanner = MTBBarcodeScanner(metadataObjectTypes: [AVMetadataObject.ObjectType.code128.rawValue], previewView: previewView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        MTBBarcodeScanner.requestCameraPermission(success: { success in
            if success {
                do {
                    try self.scanner?.startScanning(with: .back,
                        resultBlock: { codes in
                        if let codes = codes {
                            for code in codes {
                                let stringValue = code.stringValue!
                                print("Found code: \(stringValue)")
                            }
                        }
                    })
                } catch {
                    NSLog("Unable to start scanning")
                }
            } else {
                UIAlertView(title: "Scanning Unavailable", message: "This app does not have permission to access the camera", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "Ok").show()
            }
        })
    }
    
    @IBAction func scanButtonPressed(_ sender: Any) {
        self.barcodeNumber = ""
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
    
    override func viewWillDisappear(_ animated: Bool) {
        self.scanner?.stopScanning()
        
        super.viewWillDisappear(animated)
    }
    
}
