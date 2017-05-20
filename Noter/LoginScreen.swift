//
//  LoginScreen.swift
//  Noter
//
//  Created by Đoàn Minh Hoàng on 4/27/17.
//  Copyright © 2017 Đoàn Minh Hoàng. All rights reserved.
//

import UIKit
import Firebase

class LoginScreen: UIViewController {

    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var signupView: UIView!
    
    @IBOutlet weak var loginEmail: UITextField!
    @IBOutlet weak var loginPassword: UITextField!
    
    @IBOutlet weak var signupName: UITextField!
    @IBOutlet weak var signupEmail: UITextField!
    @IBOutlet weak var signupPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
            self.clearText()
            break
        case 1:
            self.loginView.isHidden = true
            self.signupView.isHidden = false
            self.clearText()
            break
        default:
            break
        }
    }
    
    @IBAction func loginButton(_ sender: UIButton) {
        FIRAuth.auth()?.signIn(withEmail: loginEmail.text!, password: loginPassword.text!) { (user, error) in
            if error != nil {
                self.showAlert("Username or password is not correct")
                self.clearText()
            }
            else {
                let userDefault = UserDefaults.standard
                userDefault.set(true, forKey: "isLoggedIn") // set login status to true if user login successfully
                userDefault.synchronize()
                self.performSegue(withIdentifier: "showNotes", sender: nil)
                self.clearText()
            }
        }
    }

    @IBAction func signupButton(_ sender: UIButton) {
        FIRAuth.auth()?.createUser(withEmail: signupEmail.text!, password: signupPassword.text!) { (user, error) in
            if error != nil {
                self.showAlert("Username or password is existed")
                self.clearText()
            }
            else {
                self.showAlert("Sign Up succesfully!")
                self.clearText()
            }
        }
    }
    
    func showAlert(_ alertMessage: String) {
        let alert = UIAlertController(title: "Alert", message: alertMessage, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func clearText() {
        loginEmail.text = nil
        loginPassword.text = nil
        signupName.text = nil
        signupEmail.text = nil
        signupPassword.text = nil
    }

}
