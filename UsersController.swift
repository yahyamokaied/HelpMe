//
//  UsersController.swift
//  helpme
//
//  Created by Yahya Mokaied on 17/06/2020.
//  Copyright © 2020 Yahya Mokaied. All rights reserved.
//

import UIKit
import FirebaseAuth


class SignUpViewController: UIViewController  {

    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var userEmail: UITextField!
    @IBOutlet weak var userPass: UITextField!
    
    
   
    @IBAction func signinBtn(_ sender: Any) {
        let loginManager = FirebaseManager()
        guard let email = userEmail.text, let password = userPass.text else { return }
        loginManager.signIn(email: email, pass: password) {[weak self] (success) in
            guard self != nil else { return }
            if (success) {
               
                self?.performSegue(withIdentifier: "GoToMainPage", sender: self)
            } else {
              let  message = "ERROR! Try again with another Email/Password"
                self!.signAlert(msg: message)
            }
        }
    }
        
    
    @IBAction func signupBtn(_ sender: Any) {
        if (name.text != ""){
        let signUpManager = FirebaseManager()
        if let email = userEmail.text, let password = userPass.text {
            signUpManager.createUser(email: email, password: password) {[weak self] (success) in
                guard self != nil else { return }
                var message: String = ""
                if (success) {
                    self?.userNameUpdate()
                    message = "User was sucessfully created."
                    
                    self?.signinBtn((Any).self)
                } else {
                    message = "ERROR! Try again with another Email/Password"
                }
                
                self?.signAlert(msg : message)
            }
        }
        }else if (name.text == ""){
            signAlert(msg: "ERROR! Please Fill your Email/Password")
        }
        
        
    }
    
    
    func userNameUpdate ()  {
        var TempName : String = ""
        TempName = name.text!
        let user = Auth.auth().currentUser
        if let user = user {
            let changeRequest = user.createProfileChangeRequest()
            
           changeRequest.displayName = TempName
            
            changeRequest.commitChanges { error in
                if error != nil {
                    self.signAlert(msg: "ERROR! Can't save your name .. try again ")
               
             } else {
                    print (user.displayName ?? "ERROR! There is no name")
               
             }
           }
         }
    }
    
    

       
   func signAlert (msg : String){
           let alertController = UIAlertController(title: nil, message: msg, preferredStyle: .alert)
           alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
           self.present(alertController, animated: true)
       }

    
    func Alert (msg : String){
        let alertController = UIAlertController(title: nil, message: msg, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertController, animated: true)
    }
    
           
    @IBAction func signOutBtn(_ sender: Any) {
        
        let alert = UIAlertController(title: "Logout", message: "Are you sure to logout ? ", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
            do
            {
                 try Auth.auth().signOut()
self.view.window?.rootViewController?.presentedViewController!.dismiss(animated: true, completion: nil)
                self.Alert(msg: "signed out successfully")
            }
            catch _ as NSError
            {
                self.Alert(msg: "ERROR! Try again later")
            }
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))

        self.present(alert, animated: true)
        
        
    }
    

   
    override func viewDidLoad() {
        super.viewDidLoad()
        print ("User ID : \(String(describing: Auth.auth().currentUser?.uid))")
        }
        }
