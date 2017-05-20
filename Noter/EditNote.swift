//
//  EditNote.swift
//  Noter
//
//  Created by Đoàn Minh Hoàng on 5/6/17.
//  Copyright © 2017 Đoàn Minh Hoàng. All rights reserved.
//

import UIKit

class EditNote: UIViewController {

    @IBOutlet weak var editNoteTitle: UILabel!
    @IBOutlet weak var editNoteContent: UITextView!
    
    let model = noteModel()
    
    var editTitle: String?
    var editContent: String?
    var editKey: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        editNoteTitle.text = editTitle!
        editNoteContent.text = editContent!
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func editNote(_ sender: UIBarButtonItem) {
        let post = ["title" : editTitle!, "content": editNoteContent.text!]
        model.editData(post, editKey!)
        self.navigationController?.popViewController(animated: true)
    }
}
