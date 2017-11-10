//
//  ViewController.swift
//  Dictionary
//
//  Created by Xiaolin Wang on 04/07/2017.
//  Copyright © 2017 Pride1952. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPopoverPresentationControllerDelegate {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    var definitionViewController: UIReferenceLibraryViewController!
    func setUpLayoutForPopover() {
        definitionViewController.popoverPresentationController?.sourceRect = textField.bounds
        let preferredWidth = traitCollection.horizontalSizeClass == .compact ? view.frame.width : view.frame.width / 2
        definitionViewController.preferredContentSize = CGSize(width: preferredWidth, height: textField.center.y)
    }
    
    @IBAction func hitSearch(_ sender: UITextField) {
        if let word = sender.text {
            if (UIReferenceLibraryViewController.dictionaryHasDefinition(forTerm: word)) {
                sender.endEditing(false)
                definitionViewController = UIReferenceLibraryViewController.init(term: word)
                definitionViewController.modalPresentationStyle = .popover
                definitionViewController.popoverPresentationController?.permittedArrowDirections = .down
                definitionViewController.popoverPresentationController?.sourceView = textField
                definitionViewController.popoverPresentationController?.delegate = self
                setUpLayoutForPopover()
                self.present(definitionViewController, animated: true, completion: nil)
            }
        }
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    @objc func keyboardWillShow(_ notification: NSNotification) {
        if let userInfo = notification.userInfo,
            let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? TimeInterval,
            //            let beginKeyboardRect = userInfo[UIKeyboardFrameBeginUserInfoKey] as? CGRect,
            let endKeyboardRect = userInfo[UIKeyboardFrameEndUserInfoKey] as? CGRect {
//            print(endKeyboardRect)
            //            let yOffset = endKeyboardRect.origin.y - beginKeyboardRect.origin.y
//            var finalFrame = textField.frame
//            finalFrame.origin.y = endKeyboardRect.origin.y - 20 - finalFrame.height
            //            print(endKeyboardRect)
            bottomConstraint.constant = -endKeyboardRect.height - 20
            UIView.animate(withDuration: duration, animations: {
                self.textField.superview?.layoutIfNeeded()
            }
//                                , completion: { (finished) in
//                                if finished {
////                                    if self.definitionViewController != nil {
////                                        self.definitionViewController.popoverPresentationController?.sourceRect = self.textField.bounds
////                                        self.definitionViewController.preferredContentSize = self.definitionViewController.view.frame.insetBy(dx: 0.0, dy: -0.01).size
////                                    }
//                                    self.textField.updateConstraints()
//                                }
//                            }
            )
        }
    }
//    func keyboardWillShow(_ notification: NSNotification) {
//        if let userInfo = notification.userInfo,
//            let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? TimeInterval {
//            var finalFrame = textField.frame
//            finalFrame.origin.x = (textField.superview?.center.x)! - finalFrame.width / 2.0
//            finalFrame.origin.y = (textField.superview?.center.y)! - finalFrame.height / 2.0
//            UIView.animate(withDuration: duration, animations: {
//                self.textField.frame = finalFrame
//            })
//        }
//    }
    
    @objc func keyboardWillHide(_ notification: NSNotification) {
        if let userInfo = notification.userInfo,
            let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? TimeInterval {
            bottomConstraint.constant = -20
            UIView.animate(withDuration: duration, animations: {
                self.textField.superview?.layoutIfNeeded()
            })
        }
    }
    
    override func viewDidLayoutSubviews() {
        if definitionViewController != nil {
            setUpLayoutForPopover()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.textField.becomeFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

