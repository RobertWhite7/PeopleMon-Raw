//
//  LoginViewController.swift
//  PeopleMon
//
//  Created by Robert White on 11/7/16.
//  Copyright © 2016 Teky. All rights reserved.
//

import UIKit
import MBProgressHUD

class LoginViewController: UIViewController {
    @IBOutlet weak var usernameField: UITextField!

    @IBOutlet weak var passwordField: UITextField!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func LoginTapped(_ sender: UIButton){
        // Validate user input
        guard let Email = usernameField.text , Email != "" else {
            // show error
            let alert = Utils.createAlert(title: "Login error", message: "Please provide an Email", dismissButtonTitle: "Close")
            present(alert, animated: true, completion: nil)
            return
        }
        
        guard let password = passwordField.text , password != "" else {
            // show error
            let alert = Utils.createAlert(title: "Login error", message: "Please provide a password", dismissButtonTitle: "Close")
            present(alert, animated: true, completion: nil)
            return
        }
        
        
        // Going to go ahead with the register
        MBProgressHUD.showAdded(to: view, animated: true)
        let user = User(email: Email, password: password)
        UserStore.shared.login(loginUser: user) { (success, error) in
            MBProgressHUD.hide(for: self.view, animated: true)
            if success {
                self.dismiss(animated: true, completion: nil)
            } else if let error = error {
                self.present(Utils.createAlert(message: error), animated: true, completion: nil)
            } else {
                self.present(Utils.createAlert(message: Constants.JSON.unknownError), animated: true, completion: nil)
            }
        }
    }
}
