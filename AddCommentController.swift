//
//  AddCommentController.swift
//  helpme
//
//  Created by Yahya Mokaied on 02/07/2020.
//  Copyright © 2020 Yahya Mokaied. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestoreSwift


class AddCommentController: UIViewController, UITableViewDelegate , UITableViewDataSource {
    
    let db = Firestore.firestore()
    var languageSeg = ""
    var DocID = ""
    var selTask : TaskDetails? = nil
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        (selTask?.comments.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell", for: indexPath)
        cell.textLabel?.text = selTask?.comments[indexPath.row]
        return cell    }
    

    
    
    @IBOutlet weak var taskTitle: UILabel!
    @IBOutlet weak var taskDesc: UITextView!
    
    @IBOutlet weak var TaskComment: UITextView!
    @IBAction func AddCommentBtn(_ sender: UIButton) {
        AddComment()
        print("comment added")
    }
    
    
    
    func AddComment() {
        let frankDocRef = db.collection(languageSeg).document(DocID)

        do {
            try frankDocRef.updateData(["comments": FieldValue.arrayUnion([TaskComment.text])
            ])
        } catch let error {
            print("Error writing city to Firestore: \(error)")
        }
    
    }
    
    
    
    @IBOutlet weak var commentsTV: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commentsTV.dataSource = self
        commentsTV.delegate = self
        
        taskTitle.text = selTask?.title
        taskDesc.text = selTask?.desc
        
        print("DocID: \(DocID)")

    }
    
}
