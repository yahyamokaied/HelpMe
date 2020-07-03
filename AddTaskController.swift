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
    var tempTask : TaskDetails? = nil
    var tempID :String = ""
    var tempTitle : String = ""
    
    @IBOutlet weak var taskTxt: UILabel!
    @IBOutlet weak var taskTitle: UITextField!
    @IBOutlet weak var taskDesc: UITextView!
    
    
    
    @IBOutlet var TasksTV: UITableView!
    var ref: DocumentReference? = nil
    var queryRef : DocumentReference? = nil
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "AddNewTaskSeg"){
            let thirdVC : AddNewTaskController =  segue.destination as! AddNewTaskController
            thirdVC.languageSeg = self.languageSeg
        }
        else if (segue.identifier == "AddCommentSeg"){
            let thirdVC : AddCommentController =  segue.destination as! AddCommentController
            thirdVC.languageSeg = self.languageSeg
            thirdVC.selTask = self.tempTask
            thirdVC.DocID = self.tempID
            print("DocID: \(tempID)")

        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
                 
              let selected = tableView.cellForRow(at: indexPath)!
                         let labelTxt = selected.textLabel?.text
                         tempTitle = labelTxt ?? ""
                         searchTask(selectedTask: tempTitle)
                         getDocID(title: tempTitle)
        performSegue(withIdentifier: "AddCommentSeg", sender: self)

    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskArr.count
    }
    
    func searchTask (selectedTask : String){
        
        for task in fetchedData {
            if (task.title == selectedTask) {
                tempTask = task
                
                print(tempTask as Any)
                
            }
            
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath)
        cell.textLabel?.text = taskArr[indexPath.row]
        return cell
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
                FetchTasks()
        print("array is here \(taskArr)")
        TasksTV.dataSource = self
        TasksTV.delegate = self
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

    
    func getDocID (title : String) {
        
        db.collection(languageSeg).whereField(title, isEqualTo: title)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        self.tempID = document.documentID
                        print("tempID : \(document.documentID) => \(document.data())")
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
            print("Error decoding : \(error)")
        }
    }
    }

}
    


