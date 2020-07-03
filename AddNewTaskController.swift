//
//  AddNewTaskController.swift
//  helpme
//
//  Created by Yahya Mokaied on 03/07/2020.
//  Copyright © 2020 Yahya Mokaied. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestoreSwift



class AddNewTaskController: UIViewController {
    @IBOutlet weak var TaskTitle: UITextField!
    
    @IBOutlet weak var TaskDesc: UITextView!
    
    let db = Firestore.firestore()
    var languageSeg = ""
    
    
    
    

    @IBAction func addTaskBtn(_ sender: UIButton) {
        AddNewTask()
        dismiss(animated:true, completion:nil)
    }
    
    func AddNewTask() {

        let newT : TaskDetails
           newT =  TaskDetails(title : TaskTitle.text!,
                               desc: TaskDesc.text,
                               comments : ["Any help ???"])
        do {
            try db.collection(languageSeg).document().setData(from: newT)
        } catch let error {
            print("Error writing city to Firestore: \(error)")
        }
        
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
