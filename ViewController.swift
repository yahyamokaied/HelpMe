//
//  ViewController.swift
//  helpme
//
//  Created by Yahya Mokaied on 10/06/2020.
//  Copyright © 2020 Yahya Mokaied. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var titleLbl: UILabel!
    override func viewDidLoad() {
        
        titleLbl.text = ""
        var charIndex = 0.0
        let titleTxt = "H E L P   M E"
        for letter in titleTxt {
            
            Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false) { (timer) in
                
                self.titleLbl.text?.append(letter)
                
            }
            charIndex += 1
        }
        
        super.viewDidLoad()
        
    }


}
