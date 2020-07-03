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


class AddCommentController: UIViewController {
    let db = Firestore.firestore()
    var languageSeg = ""
    
    @IBOutlet weak var TaskComment: UITextView!
    
    @IBAction func AddCommentBtn(_ sender: UIButton) {
        AddComment()
        print("comment added")
    }
    
    
    
    func AddComment() {
        let tComment = TaskComment.text
        var ref: DocumentReference? = nil
        ref = db.collection(languageSeg).addDocument(data: [
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
