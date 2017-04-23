//
//  ViewController.swift
//  Noter
//
//  Created by Đoàn Minh Hoàng on 4/22/17.
//  Copyright © 2017 Đoàn Minh Hoàng. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var signupView: UIView!
    @IBOutlet weak var loginEmail: UITextField!
    @IBOutlet weak var loginPassword: UITextField!
    @IBOutlet weak var signupName: UITextField!
    @IBOutlet weak var signupEmail: UITextField!
    @IBOutlet weak var signupPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func segmentChange(_ sender: UISegmentedControl) {
        switch (sender.selectedSegmentIndex) {
        case 0:
            self.loginView.isHidden = false
            self.signupView.isHidden = true
            break
        case 1:
            self.loginView.isHidden = true
            self.signupView.isHidden = false
            break
        default:
            break
        }
    }

    @IBAction func loginButton(_ sender: UIButton) {
        FIRAuth.auth()?.signIn(withEmail: loginEmail.text!, password: loginPassword.text!) { (user, error) in
            if error != nil {
                let alert = UIAlertController(title: "Alert", message: "Username or password is not correct",preferredStyle:UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            else {
                let alert = UIAlertController(title: "Alert", message: "Login succesfully!",preferredStyle:UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func signupButton(_ sender: UIButton) {
        FIRAuth.auth()?.createUser(withEmail: signupEmail.text!, password: signupPassword.text!) { (user, error) in
            if error != nil {
                let alert = UIAlertController(title: "Alert", message: "Username or password is existed",preferredStyle:UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            else {
                let alert = UIAlertController(title: "Alert", message: "Sign Up succesfully!",preferredStyle:UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}

