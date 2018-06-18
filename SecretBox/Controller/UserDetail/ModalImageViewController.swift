//
//  ModalImageViewController.swift
//  SecretBox
//
//  Created by José Victor Pereira Costa on 17/06/18.
//  Copyright © 2018 José Victor Pereira Costa. All rights reserved.
//

import UIKit


protocol ModalImageViewControllerDelegate: class {
    func getStatePadLock(ModalImageViewControllerDelegate: ModalImageViewController) -> Bool
}

class ModalImageViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    weak var delegate: ModalImageViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lockUnlock()
        startAsyncTimeDismiss()
    }
    
    func startAsyncTimeDismiss() {
        let when = DispatchTime.now() + 1
        DispatchQueue.main.asyncAfter(deadline: when){
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func lockUnlock() {
        
        guard let modalDelegate = delegate else {
            return
        }
        let state = modalDelegate.getStatePadLock(ModalImageViewControllerDelegate: self)
        let imagePath = state ? "ic-lock-open" : "ic-lock-close"
        if let image = UIImage(named: imagePath ) {
            imageView.image = image
        }
    }
}

