//
//  ProfileController.swift
//  helpme
//
//  Created by Yahya Mokaied on 17/06/2020.
//  Copyright © 2020 Yahya Mokaied. All rights reserved.
//

import UIKit
import Firebase

class ProfileController: UIViewController {
    
    var userType : Int = 0
    var userEmail : String = ""
    
    @IBAction func continueBtn(_ sender: UIButton) {
        performSegue(withIdentifier: "toPrepareSearch", sender: self)
    }
    
    @IBOutlet weak var statusSegment: UISegmentedControl!
    @IBAction func statusSegment(_ sender: Any) {
        userType = statusSegment.selectedSegmentIndex
    }
    
    
    @IBAction func deleteUser(_ sender: Any) {
        
        let alert = UIAlertController(title: "Delete User", message: "we hope to see you again .. you", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "I agree that I will lose all my data", style: .default, handler: { action in
            
            let user = Auth.auth().currentUser

            user?.delete { error in
                if error != nil {
                    self.Alert(msg: "ERROR! Try again later ")
              } else {
                    
                    self.navigationController?.popToRootViewController(animated: true)
                    self.Alert(msg: "Deleted successfully")
                    
              }
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        self.present(alert, animated: true)
    }
    @IBAction func signOutBtn(_ sender: Any) {
        
        let alert = UIAlertController(title: "Logout", message: "Are you sure to logout ? ", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
            do
            {
                 try Auth.auth().signOut()
                self.navigationController?.popToRootViewController(animated: true)
                self.Alert(msg: "signed out successfully")
            }catch _ as NSError
            {
                self.Alert(msg: "ERROR! Try again later")
            }
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))

        self.present(alert, animated: true)
        
        
    }
    @IBAction func changePwdBtn(_ sender: Any) {
        Auth.auth().sendPasswordReset(withEmail: userEmail) { error in
            
            self.Alert(msg: "You will receive an Email soon ..")
        }
        
    }
    
    func Alert (msg : String){
        let alertController = UIAlertController(title: nil, message: msg, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertController, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toPrepareSearch"){
          //  let secondVC : TasksController =  segue.destination as! TasksController
       //     secondVC.isTeacher = valueToBool(value: userType)
        }
       
    }
    
    func valueToBool (value : Int) -> Bool{
        if value != 0 {
            return true
        }else {
            return false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print ("User ID : \(String(describing: Auth.auth().currentUser?.uid))")
        
        
        userEmail = (Auth.auth().currentUser?.email)!
        navigationItem.hidesBackButton = true
    }
}

