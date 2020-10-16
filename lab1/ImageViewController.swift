//
//  ImageViewController.swift
//  lab1
//
//  Created by Dan Luncasu on 10/15/20.
//

import UIKit

class ImageViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var takenImage:UIImage?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        if let available = takenImage {
            imageView.image = available
        }
    }
    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
