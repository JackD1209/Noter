//
//  NotesScreen.swift
//  Noter
//
//  Created by Đoàn Minh Hoàng on 4/27/17.
//  Copyright © 2017 Đoàn Minh Hoàng. All rights reserved.
//

import UIKit
import Firebase

class NotesScreen: UIViewController, UITableViewDataSource, UITableViewDelegate, noteModelDelegate{

    @IBOutlet weak var notesList: UITableView!
    
    let model = noteModel()
    
    var noteEditTitle: String?
    var noteEditContent: String?
    var noteEditKey: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model.delegate = self
        notesList.dataSource = self
        notesList.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        model.notes.removeAll()
        model.loadData()
        notesList.reloadData()
    }
    
    func gotData(notes: [note]) {
        notesList.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.notes.count
    }
    
    func tableView(_ tableView: UITableView , cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Note") as! NoteCell
        cell.noteLabel.text = model.notes[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        noteEditTitle = model.notes[indexPath.row].title
        noteEditContent = model.notes[indexPath.row].content
        noteEditKey = model.notes[indexPath.row].key
        self.performSegue(withIdentifier: "editNote", sender: nil) // move to edit screen with suitable data
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            // handle delete (by removing the data from your array and updating the tableview)
            model.removeData(indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
        }
    }

    @IBAction func logoutButton(_ sender: UIBarButtonItem) {
        do {
            try model.firebaseAuth?.signOut()
            let userDefault = UserDefaults.standard
            userDefault.set(false, forKey: "isLoggedIn") // set login status to false when user logout successfully
            userDefault.synchronize()
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let loginScreen = storyBoard.instantiateViewController(withIdentifier: "loginScreen")
            self.present(loginScreen, animated: true, completion: nil)
//            UIApplication.shared.keyWindow?.rootViewController = loginScreen // incase there are some intro screen before
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editNote" {
            let editVC = segue.destination as! EditNote // send suitable data to edit screen
            editVC.editTitle = noteEditTitle
            editVC.editContent = noteEditContent
            editVC.editKey = noteEditKey
        }
    }
}
