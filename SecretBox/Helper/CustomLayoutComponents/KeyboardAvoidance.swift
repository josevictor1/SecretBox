//
//  KeyboardAvoidance.swift
//  SecretBox
//
//  Created by José Victor Pereira Costa on 15/06/18.
//  Copyright © 2018 José Victor Pereira Costa. All rights reserved.
//

import UIKit

class KeyboardAvoidance: UIViewController {
    
    var scrollViewToAvoid = UIScrollView()
    
    /// receives the scrollView add set the observers with animation functions
    ///
    /// - Parameter scrollView: scrollView where the functions will be aplied
    func setKeyboardToAvoid(scrollView: UIScrollView) {
        scrollViewToAvoid = scrollView
        scrollView.keyboardDismissMode = .interactive
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    ///  animation that scrolls the view
    ///
    /// - Parameter notification: called when the keyboard will show
    @objc func keyboardWillShow(notification: NSNotification) {
        
        guard let info = notification.userInfo else{
            return
        }
        let keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let bottomInset = keyboardFrame.height != 0 ? keyboardFrame.height + 20 : 0
        
        UIView.animate(withDuration: 0.25, animations: { () -> Void in
            self.scrollViewToAvoid.contentInset = UIEdgeInsets(top: self.scrollViewToAvoid.contentInset.top,
                                                               left: self.scrollViewToAvoid.contentInset.left,
                                                               bottom: bottomInset,
                                                               right: self.scrollViewToAvoid.contentInset.right)
        })
    }
    
    /// animation that returns the view to the original state
    ///
    /// - Parameter notification: called ehrn the keyboard will hide
    @objc func keyboardWillHide(notification: NSNotification) {
        UIView.animate(withDuration: 0.25, animations: { () -> Void in
            self.scrollViewToAvoid.contentInset = UIEdgeInsets(top: self.scrollViewToAvoid.contentInset.top,
                                                               left: self.scrollViewToAvoid.contentInset.left,
                                                               bottom: 0,
                                                               right: self.scrollViewToAvoid.contentInset.right)
        })
    }
}
