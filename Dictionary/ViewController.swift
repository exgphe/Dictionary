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
    func keyboardWillChangeFrame(_ notification: NSNotification) {
        if let userInfo = notification.userInfo,
            let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? TimeInterval,
            //            let beginKeyboardRect = userInfo[UIKeyboardFrameBeginUserInfoKey] as? CGRect,
            let endKeyboardRect = userInfo[UIKeyboardFrameEndUserInfoKey] as? CGRect {
            //            let yOffset = endKeyboardRect.origin.y - beginKeyboardRect.origin.y
            var finalFrame = textField.frame
            finalFrame.origin.y = endKeyboardRect.origin.y - 20 - finalFrame.height
            //            print(endKeyboardRect)
            UIView.animate(withDuration: duration, animations: {
                self.textField.frame = finalFrame
            }
                //                , completion: { (finished) in
                //                if finished {
                //                    if self.definitionViewController != nil {
                //                        self.definitionViewController.popoverPresentationController?.sourceRect = self.textField.bounds
                //                        self.definitionViewController.preferredContentSize = self.definitionViewController.view.frame.insetBy(dx: 0.0, dy: -0.01).size
                //                    }
                //                }
                //            }
            )
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
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.textField.becomeFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

