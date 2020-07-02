//
//  HelpMeController.swift
//  helpme
//
//  Created by Yahya Mokaied on 17/06/2020.
//  Copyright © 2020 Yahya Mokaied. All rights reserved.
//

import UIKit
import Firebase

class HelpMeController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var userName = (Auth.auth().currentUser?.displayName ?? "No name !!!")
    var userEmail = Auth.auth().currentUser?.email
    var city : String = ""
    let db = Firestore.firestore()
    var ref: DocumentReference? = nil
    var isTeacher : Bool? = nil
    var resultList : [Users] = []
    var subject : String = ""
    
    @IBOutlet weak var addYouBtnOutlet: UIButton!
    @IBOutlet weak var helloMess: UITextView!
    
    @IBAction func addYou(_ sender: UIButton) {
        addMe()
    }
    @IBOutlet weak var matchTV: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        matchTV.delegate = self
        matchTV.dataSource = self
        helloMess.isHidden = true
        
        if (isTeacher!){
            addYouBtnOutlet.setTitle("Add yourself as a educationist", for: .normal)
        }else if (isTeacher == false){
            addYouBtnOutlet.setTitle("Add yourself as a student", for: .normal)
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           //
        return resultList.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "myMatchCell", for: indexPath)
       
        cell.textLabel?.text = ("Name : \(resultList[indexPath.row].name)" + " - E.price/h : \(resultList[indexPath.row].price)")
        return cell
        }
    
    override func viewDidDisappear(_ animated: Bool) {
        resultList.removeAll()
        print("here is after death new \(resultList)")
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        let selectedUser = resultList[indexPath.row]
        showTheInfo(user: selectedUser)
        }
    
    
    func showTheInfo (user : Users){
        helloMess.isHidden = false
        if (isTeacher! == false){
            helloMess.text = "Hello ! \(user.name) is my name , i can teach \(user.subjectName) . Please feel free send an email to me on this adress : \(user.email)  "
        }else if (isTeacher!){
            helloMess.text = "Hello ! \(user.name) is my name , i need help with \(user.subjectName) . Please feel free send an email to me on this adress : \(user.email)  "
        }
        
        
    }
    
    func upLoadMe (newPrice : String){
        
    
        let U22 : Users
           U22 =  Users(subjectName: subject, name: userName,
                            email : userEmail!,
        price: newPrice, isTeacher: isTeacher!)
        
        do {
            try db.collection(city).document().setData(from: U22)
            Alert(msg: "You added yourself to this subject's users")
        } catch let error {
            print("Error  \(error)")
        }
    }
    
    
    func addMe ()  {
        let alert = UIAlertController(title: "Add yourself", message: "Please enter a expected price per hour", preferredStyle: .alert)
        alert.addTextField()
       
        
        alert.textFields![0].placeholder = "Enter the price per hour"
        alert.addAction(UIAlertAction(title : "Cancel" , style: .cancel,handler: {(ACTION) in }))
        alert.addAction(UIAlertAction(title : "Add" , style: .default , handler: {(ACTION) in
            
            let mPrice = alert.textFields![0].text
            self.upLoadMe(newPrice: mPrice!)
        }))
        self.present(alert , animated: true)
    }
    
    func Alert (msg : String){
        let alertController = UIAlertController(title: nil, message: msg, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertController, animated: true)
    }
    }
