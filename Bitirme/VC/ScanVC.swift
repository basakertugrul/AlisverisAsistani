//
//  ScanVC.swift
//  Bitirme
//
//  Created by Başak Ertuğrul on 16.04.2021.
//

import UIKit
import MTBBarcodeScanner

class ScanVC: UIViewController {

    var barcodeNumber: String = ""
    @IBOutlet var previewView: UIView!
        var scanner: MTBBarcodeScanner?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.previewView.layer.cornerRadius = 10.0
        self.previewView.layer.shadowColor = UIColor.gray.cgColor
        self.previewView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.previewView.layer.shadowRadius = 6.0
        self.previewView.layer.shadowOpacity = 0.7
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
                                print(stringValue)
                                self.barcodeNumber = stringValue
                                self.scanner?.stopScanning()
                                self.scanButtonPressed()
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
    
    func scanButtonPressed() {
        
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
