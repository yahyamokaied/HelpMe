//
//  TasksController.swift
//  helpme
//
//  Created by Yahya Mokaied on 17/06/2020.
//  Copyright © 2020 Yahya Mokaied. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestoreSwift

class TasksController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    
    
    let db = Firestore.firestore()

}
      /*var isTeacher : Bool? = nil
    var ref: DocumentReference? = nil
    var cities : [String] = ["Stockholm" , "Göteborg"]
    var selectedCity : String = ""
    var selectedSubject : String = ""
    var queryRef : DocumentReference? = nil
    var subjecWithData : [Users] = []
    var unfilteredData : [Users] = []
    var filteredList : [Users] = []
    
    var userName = (Auth.auth().currentUser?.displayName ?? "No name !!!")
    var userEmail = Auth.auth().currentUser?.email
    
  
    @IBOutlet weak var subjectText: UITextField!
    @IBOutlet weak var citiesTV: UITableView!
    
    @IBOutlet weak var seachOutlet: UIButton!
    
    @IBAction func searchBtn(_ sender: UIButton) {
        searchSubject()
    }
    
    @IBOutlet weak var matchBtn: UIButton!
    @IBAction func matchBtnAction(_ sender: UIButton) {
        performSegue(withIdentifier: "matchSeg", sender: self)
        }
    
        func loadCities(){
               self.citiesTV.reloadData()
               }
        func searchSubject (){
            if subjectText.text == "" {
                Alert(msg: "You have to write a subject ex : Math 3")
            }else {
                let text = subjectText.text
                db.collection(selectedCity).whereField("subjectName", isEqualTo: text!)
                .getDocuments() { (querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else if querySnapshot!.documents .isEmpty {
                        
                        
                        let addNewSubjectAlert = UIAlertController(title: "Add a new Subject", message: "Sorry , its look like we don't have this subject in our database , do you want to add it ? ", preferredStyle: UIAlertController.Style.alert)

                        addNewSubjectAlert.addAction(UIAlertAction(title: "Add", style: .default, handler: { (action: UIAlertAction!) in
                            self.alertWithText()
                          }))
                        addNewSubjectAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
                          
                          }))

                        self.present(addNewSubjectAlert, animated: true, completion: nil)
                    
                    }else {
                        self.selectedSubject = text!
                    for document in querySnapshot!.documents {
                        
                        
                        self.convertDatatoObject(d: document)
                        
                    }
            }
        }
    }
    }
    func alertWithText ()  {
        let alert = UIAlertController(title: "Add new subject", message: "Please enter a subject name ex: Math 5 and the price per hour", preferredStyle: .alert)
        alert.addTextField()
        alert.addTextField()
        alert.textFields![0].placeholder = "Enter subject's name"
        alert.textFields![1].placeholder = "Enter the price per hour"
        alert.addAction(UIAlertAction(title : "Cancel" , style: .cancel,handler: {(ACTION) in }))
        alert.addAction(UIAlertAction(title : "Add" , style: .default , handler: {(ACTION) in
            let subName = alert.textFields![0].text
            let mPrice = alert.textFields![1].text
            self.upLoadNewSubject(newSub: subName!, newPrice: mPrice!)
        }))
        self.present(alert , animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // citiesTV.delegate = self
        citiesTV.dataSource = self
        print(isTeacher!)
        matchBtn.isEnabled = false
        seachOutlet.isEnabled = false
        
        
        
       
    }
    
    
   
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "matchSeg"){
            let secondVC : HelpMeController =  segue.destination as! HelpMeController
            
            secondVC.isTeacher = self.isTeacher
            secondVC.resultList = self.subjecWithData
            secondVC.subject = self.selectedSubject
            secondVC.city = self.selectedCity
            
           
        }
       
    }
    
    func convertDatatoObject (d: DocumentSnapshot){
        let docRef = db.collection(selectedCity).document(d.documentID)

        docRef.getDocument { (document, error) in
            let result = Result {
                try document.flatMap {
                    try $0.data(as: Users.self)
                }
            }
            switch result {
            case .success(let final):
                if let userData = final {
                    
                    self.unfilteredData.append(userData)
                    print(userData)
                    
                    self.filterTheList()
                } else {
                    print("Document does not exist")
                }
            case .failure(let error):
                print("Error decoding city: \(error)")
            }
        }
    }


    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)  {
      
        var choosenCity = ""
        
        if tableView == citiesTV {
            let cell = tableView.cellForRow(at: indexPath)!
                let labelContent = cell.textLabel?.text
                choosenCity = labelContent ?? ""
                selectedCity = choosenCity
                print(selectedCity)
            seachOutlet.isEnabled = true
   
       }
    }
        
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
            let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath)
            cell.textLabel?.text = cities[indexPath.row]
            
            return cell
 
    }
   
    func Alert (msg : String){
        let alertController = UIAlertController(title: nil, message: msg, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertController, animated: true)
    }
    
    func upLoadNewSubject (newSub : String , newPrice : String ){
        let U22 : Users
           U22 =  Users(subjectName: newSub, name: userName,
                            email : userEmail!,
        price: newPrice, isTeacher: isTeacher!)
        
        do {
            try db.collection(selectedCity).document().setData(from: U22)
            Alert(msg: "New subject added succefully")
        } catch let error {
            print("Error writing city to Firestore: \(error)")
        }
    }
    
    func filterTheList(){
        self.matchBtn.isEnabled = true
        self.matchBtn.setTitle("I'm working , please wait", for: .normal)
        self.matchBtn.isEnabled = false
        
        if (isTeacher!){
            for user in unfilteredData {
                if (user.isTeacher){
                    subjecWithData = unfilteredData.filter({$0.isTeacher == false})
                    
                    
                    self.matchBtn.isEnabled = true
                    self.matchBtn.setTitle("Show the results", for: .normal)
                }
            }
        }else if (isTeacher! == false) {
            for user in unfilteredData {
                if (user.isTeacher == false){
                    subjecWithData = unfilteredData.filter({$0.isTeacher})
                    
                    
                    self.matchBtn.isEnabled = true
                    self.matchBtn.setTitle("Show the results", for: .normal)
                }
            }
            
        }
        
        

    }
    
    override func viewDidDisappear(_ animated: Bool) {
        subjecWithData.removeAll()
        unfilteredData.removeAll()
        
    }
    
    // end of view controller

}
