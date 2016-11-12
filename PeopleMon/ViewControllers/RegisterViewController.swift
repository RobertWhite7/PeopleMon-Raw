//
//  RegisterViewController.swift
//  PeopleMon
//
//  Created by Robert White on 11/7/16.
//  Copyright © 2016 Teky. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var usernameField: UITextField!

    @IBOutlet weak var emailField: UITextField!
 
    @IBOutlet weak var passwordField: UITextField!
    
  //  @IBOutlet weak var confirmField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func registerTapped(_ sender: UIButton){
        // Validate user input
        guard let fullName = usernameField.text, fullName != "" else {
            present(Utils.createAlert(title: "Login Error", message: "Please provide your name"), animated: true, completion: nil)
            return
        }
        
        guard let email = emailField.text, email != "" && Utils.isValidEmail(testStr: email) else {
            present(Utils.createAlert(title: "Login Error", message: "Please provide a valid email address"), animated: true, completion: nil)
            return
        }
        
        guard let password = passwordField.text, password != "" else {
            present(Utils.createAlert(title: "Login Error", message: "Please provide a password"), animated: true, completion: nil)
            return
        }
        
     
        
        MBProgressHUD.showAdded(to: view, animated: true)
        
       
        let user = User(email: email, password: password, fullName: fullName)
        UserStore.shared.register(registerUser: user) { (success, error) in
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

        // Going to go ahead with the register
 /*       MBProgressHUD.showAdded(to: view, animated: true)
        
       let user = Account(Email: email, fullname: fullname, password: password)
        
          UserStore.shared.register(user) { (success, error) in
            MBProgressHUD.hide(for: self.view, animated: true)
            
            if success {
                self.dismiss(animated: true, completion: nil)
            }else if let error = error {
                self.present(Utils.createAlert(message: error), animated: true, completion: nil)
            }else{
                self.present(Utils.createAlert(message: Constants.JSON.unknownError), animated: true, completion: nil)
            }
        }
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
*/
