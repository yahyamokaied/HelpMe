//
//  AddTaskController.swift
//  helpme
//
//  Created by Yahya Mokaied on 02/07/2020.
//  Copyright © 2020 Yahya Mokaied. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestoreSwift

class AddTaskController: UIViewController, UITableViewDelegate , UITableViewDataSource {
    
    
    let db = Firestore.firestore()
    var languageSeg = ""
    var taskArr : [String] = []
    var fetchedData : [TaskDetails] = []
    var selTask : String = ""
    var tempTask : TaskDetails? = nil
    
    @IBOutlet var TasksTV: UITableView!
    var ref: DocumentReference? = nil
    var queryRef : DocumentReference? = nil
    //var unfilteredData : [TaskDetails] = []
    //var filteredList : [TaskDetails] = []
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskArr.count
    }
    
    func searchTask (selectedTask : String){
        
        for task in fetchedData {
            if (task.title == selectedTask) {
                tempTask = task
                
                print(tempTask)
                
            }
            
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath)
        cell.textLabel?.text = taskArr[indexPath.row]
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selected = tableView.cellForRow(at: indexPath)!
        let labelTxt = selected.textLabel?.text
        searchTask(selectedTask: labelTxt!)
    }
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
                FetchTasks()
        print("array is here \(taskArr)")
        TasksTV.dataSource = self
        TasksTV.delegate = self
        
        // Do any additional setup after loading the view.
    }
    

        func FetchTasks (){
 db.collection(languageSeg).getDocuments() {
                    (querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                    for document in querySnapshot!.documents {
                        print("Hello iam here ")
                        
                        
                        self.convertDatatoObject(d: document)
                        
                    }
            }
        }

    }

func convertDatatoObject (d: DocumentSnapshot){
    
    
    let docRef = db.collection(languageSeg).document(d.documentID)

    docRef.getDocument { (document, error) in
        let result = Result {
          try document?.data(as: TaskDetails.self)
        }
        switch result {
        case .success(let newTask):
            if let newTask = newTask {
                self.taskArr.append(newTask.title)
                print ("new array here \(self.taskArr)")
                self.TasksTV.reloadData()
                print("Here new Task for your eyes: \(newTask)")
                self.fetchedData.append(newTask)
            } else {
                print("Document does not exist")
            }
        case .failure(let error):
            print("Error decoding city: \(error)")
        }
    }
    }

}
    
    /*
    let docRef = db.collection(languageSeg).document(d.documentID)
    //print ("id is " \(d.doc))

               docRef.getDocument { (document, error) in
                   if let document = document, document.exists {
                      // let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                      // print("Document data: \(dataDescription)")
                    try document.flatMap {
                         try $0.data(as: TaskDetails.self)
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
                    
                    
                    
                   } else {
                       print("Document does not exist")
                   }
               }
    

    
    let docRef = db.collection(languageSeg).document(d.documentID)

    docRef.getDocument { (document, error) in
        let result = Result {
            try document.flatMap {
                try $0.data(as: TaskDetails.self)
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
*/


