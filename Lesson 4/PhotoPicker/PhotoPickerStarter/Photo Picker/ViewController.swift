//
//  ViewController.swift
//  Photo Picker
//
//  Created by robkerr@mobiletoolworks on 11/19/2018.
//  Copyright © 2017 Rob Kerr. All rights reserved.
//
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    let picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func takePhoto(_ sender: UIButton) {
        picker.sourceType = .photoLibrary
        self.present(picker, animated: true, completion: nil)
    }
    

}

