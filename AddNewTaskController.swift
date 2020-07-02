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
        print("ggg")
        AddNewTask()
        dismiss(animated:true, completion:nil)

    }
    
    func AddNewTask() {
        let tTitle = TaskTitle.text
        let tDesc = TaskDesc.text

        
        var ref: DocumentReference? = nil
        ref = db.collection(languageSeg).addDocument(data: [
            "title": tTitle,
            "desc": tDesc,
            "comments": "Any Help ???"
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AddNewTask()
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
