//
//  AddNote.swift
//  Noter
//
//  Created by Đoàn Minh Hoàng on 4/27/17.
//  Copyright © 2017 Đoàn Minh Hoàng. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class AddNote: UIViewController {

    @IBOutlet weak var noteTitle: UITextField!
    @IBOutlet weak var noteContent: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func doneButton(_ sender: UIBarButtonItem) {
        let databaseRef: FIRDatabaseReference!
        let user = FIRAuth.auth()!.currentUser
        
        if noteTitle.text == nil {
            if noteContent.text == nil {
                self.showAlert("Please input your note")
            }
            else {
                self.showAlert("Please input the title of your note")
            }
        }
        else {
            let post = ["title" : noteTitle.text!, "content": noteContent.text!]
            databaseRef = FIRDatabase.database().reference()
            databaseRef.child(user!.uid).childByAutoId().setValue(post) // add note to firebase database for current user
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func showAlert(_ alertMessage: String) {
        let alert = UIAlertController(title: "Alert", message: alertMessage, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
