//
//  ViewController.swift
//  helpme
//
//  Created by Yahya Mokaied on 10/06/2020.
//  Copyright © 2020 Yahya Mokaied. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet var quoteLabel: UILabel!
    @IBOutlet var quoteTextField: UITextField!
    @IBOutlet var authorTextField: UITextField!
    
    var docRef: DocumentReference!
    var quoteListener: ListenerRegistration!

    @IBAction func saveTapped(_ sender: Any) {
        guard let quoteText = quoteTextField.text, !quoteText.isEmpty else { return }
        guard let quoteAuthor = authorTextField.text, !quoteAuthor.isEmpty else { return }
        let dataToSave: [String: Any] = ["quote":quoteText,"author":quoteAuthor]
        docRef?.setData(dataToSave){ (error) in
            if let error = error {
                print("Got Error \(error.localizedDescription)")
        }
            else {
                print("Data Sent")
            }
        }
    }
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in

        }
        
        
        quoteListener = docRef.addSnapshotListener { (docSnapshot, error) in
            guard let docSnapshot = docSnapshot, docSnapshot.exists else { return }
            let myData = docSnapshot.data()
            let latestQuote = myData?["quote"] as? String ?? ""
            let quoteAuthor = myData?["author"] as? String ?? "(none)"
            self.quoteLabel.text = "\"\(latestQuote)\" -- \(quoteAuthor)"
        }
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        
        
        quoteListener.remove()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        docRef = Firestore.firestore().document("sampleData/inspiration")

    }


    
    @IBAction func loginTapped(_ sender: UIButton) {
        
        let authUI = FUIAuth.defaultAuthUI()
        
        guard authUI != nil else {
            return
        }
        
        authUI.delegate = self
        
        let authViewController = authUI.authViewController()
        
        present(authViewController, animated: true, completion: nil)
        
    }
    
}

extension ViewController: FUIAuthDelegate {
    func authUI(_ authUI: FUIAuth, didDignInWith authDataResult:
    AuthDataResult?, error: Error?) {
        if error != nil {
            return
        }
       // authDataResult?.user.uid
        
        preform
    }
}
