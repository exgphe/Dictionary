//
//  ViewController.swift
//  Dictionary
//
//  Created by Xiaolin Wang on 04/07/2017.
//  Copyright © 2017 Pride1952. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBAction func editingDidEnd(_ sender: UITextField) {
        if let word = sender.text {
            if (UIReferenceLibraryViewController.dictionaryHasDefinition(forTerm: word)) {
                let definitionViewController = UIReferenceLibraryViewController.init(term: word)
                
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

