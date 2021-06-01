////
////  ScanVC.swift
////  Bitirme
////
////  Created by Başak Ertuğrul on 16.04.2021.
////
//import AVFoundation
//import UIKit
//
//class ScanVC: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
//
//    @IBOutlet weak var scanButton: UIButton!
//    @IBOutlet weak var barcode: UITextField!
//
//    var barcodeNumber: String = ""
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view.
//        scanButton.layer.cornerRadius = 50
//    }
//
//    @IBAction func scanButtonPressed(_ sender: Any) {
//        self.barcodeNumber = barcode.text ?? ""
//        if barcodeNumber == "" {
//            let gif = UIImage.gifImageWithName("scanError")
//            let imageView = UIImageView(image: gif)
//            imageView.frame = CGRect(x: -20, y: 385, width: 467.25, height: 350)
//            view.addSubview(imageView)
//            DispatchQueue.main.asyncAfter(deadline: .now() + 8) {
//                imageView.removeFromSuperview()
//            }
//        }
//        else{
//            let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
//            let vc = mainStoryboard.instantiateViewController(withIdentifier: "productVC") as! ProductVC
//            vc.modalPresentationStyle = .fullScreen
//            vc.barcodeNumber = self.barcodeNumber
//            present(vc, animated: true, completion: nil)
//        }
//    }
//
//}

//  ScannerViewController.swift
//  BarCodeScanner
//  Created by 1 on 11/27/20.
import AVFoundation
import UIKit

class ScanVC: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    var barcodeNumber: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setupCaptureSession() {
        view.backgroundColor = UIColor.black
        captureSession = AVCaptureSession()
        
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }
        
        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            failed()
            return
        }
        //Initialize an AVCaptureMetadataOutput object and set it as the output device to the capture session.
        let metadataOutput = AVCaptureMetadataOutput()
        
        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)
            //Set delegate and use default dispatch queue to execute the call back
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.ean8, .ean13, .pdf417]
        } else {
            failed()
            return
        }
        //Initialize the video preview layer and add it as a sublayer.
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)
        //Start video capture
        captureSession.startRunning()
    }
    
    func failed() {
        let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        captureSession = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let videoAuthStatus = AVCaptureDevice.authorizationStatus(for: .video)
           switch (videoAuthStatus) {
           case .authorized:
            setupCaptureSession()
               
           case .denied, .restricted:
               // Show error
               break
               
           case .notDetermined:
                AVCaptureDevice.requestAccess(for: .video) { response in
                    if response {
                        self.captureSession.startRunning()
                        self.setupCaptureSession()
                    }
                    else{
                      
                    }
                }
           @unknown default:
            break
           }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if (captureSession?.isRunning == true) {
            captureSession.stopRunning()
        }
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        captureSession.stopRunning()
        
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            found(code: stringValue)
        }
        
        dismiss(animated: true)
    }
    
    func found(code: String) {
        print(code)
        self.barcodeNumber = code
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "productVC") as! ProductVC
        vc.modalPresentationStyle = .fullScreen
        vc.barcodeNumber = self.barcodeNumber
        present(vc, animated: true, completion: nil)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
}
