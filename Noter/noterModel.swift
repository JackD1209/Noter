//
//  noterModel.swift
//  Noter
//
//  Created by Đoàn Minh Hoàng on 5/19/17.
//  Copyright © 2017 Đoàn Minh Hoàng. All rights reserved.
//

import UIKit
import Firebase

struct note {
    var key: String!
    var title: String!
    var content: String!
}

protocol noteModelDelegate {
    func gotData(notes: [note])
}

class noteModel {
    
    var notes = [note]()
    var delegate: noteModelDelegate?
    
    let databaseRef: FIRDatabaseReference! = FIRDatabase.database().reference()
    let user = FIRAuth.auth()!.currentUser
    let firebaseAuth = FIRAuth.auth()
    
    func loadData() { // this function is for load the data from firebase and put it into an array of struct note
        databaseRef.child(user!.uid).queryOrderedByKey().observe(.childAdded , with: {
            (snapshot) in
            let value = snapshot.value as? [String: String]
            let refKey = snapshot.key as String // get the key generated by autoID
            let refTitle = value!["title"] // get the title of the note
            let refContent = value!["content"] // get the content of the note
            self.notes.append(note(key: refKey, title: refTitle, content: refContent))

            if self.notes.count > 0 {
                self.delegate?.gotData(notes: self.notes)
            }
        })
    }
    
    func removeData(_ index: Int) {
        databaseRef.child(user!.uid).child(notes[index].key).removeValue() // remove data from firebase
        notes.remove(at: index) // remove data from array of struct note
    }
    
    func editData(_ post: [String: String], _ editKey: String) {
        let updateRef = FIRDatabase.database().reference().child("\(user!.uid)/\(editKey)") // edit the note from firebase
        updateRef.updateChildValues(post)
    }
    
    func addData(_ post: [String: String]) {
        databaseRef.child(user!.uid).childByAutoId().setValue(post) // add note to firebase database for current user
    }
}