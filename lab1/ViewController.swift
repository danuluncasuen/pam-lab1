//
//  ViewController.swift
//  lab1
//
//  Created by Dan Luncasu on 10/14/20.
//

import UIKit
import SafariServices

class ViewController: UIViewController {
    
    @IBOutlet weak var cameraChoice: UISegmentedControl!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var textInputSearch: UITextField!
        
    var takenImage:UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func openCamera(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = self
        if cameraChoice.selectedSegmentIndex == 1 {
            picker.cameraDevice = .front
        } else {
            picker.cameraDevice = .rear
        }
        present(picker, animated: true, completion:nil)
    }
    
    @IBAction func seachByValue(_ sender: Any) {
        textInputSearch.becomeFirstResponder()
        let key = textInputSearch.text
        let scheme = "https"
        let host = "www.google.com"
        let path = "/search"
        let queryItem = URLQueryItem(name: "q", value: key)


        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = path
        urlComponents.queryItems = [queryItem]

        if let url = urlComponents.url {
            let safari = SFSafariViewController(url: url)
            present(safari, animated: true, completion: nil)
        }
    }
    
    @IBAction func helloNotify(_ sender: Any) {
        let alertView = UIAlertController(title: "Hello", message: "You clicked the button", preferredStyle: UIAlertController.Style.alert)
        alertView.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.default, handler: nil))
        self.present(alertView, animated: true, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
            alertView.dismiss(animated: false, completion: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "imageViewSegue" {
            let vc = segue.destination as! ImageViewController
            vc.takenImage = self.takenImage
        }
    }
    
    @IBAction func viewPicture(_ sender: Any) {
        takenImage = imageView.image
        performSegue(withIdentifier: "imageViewSegue", sender: self)
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        
        let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        
        self.imageView.image = image
    }
}

