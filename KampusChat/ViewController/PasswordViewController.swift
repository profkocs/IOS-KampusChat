//
//  PasswordViewController.swift
//  KampusChat
//
//  Created by Burak on 20.03.2021.
//  Copyright © 2021 KampusChat. All rights reserved.
//

import UIKit

class PasswordViewController: UIViewController {

    var signupViewModel:SignupViewModel!
    
    @IBOutlet weak var textfieldPassword: UITextField!
    @IBOutlet weak var labelPasswordStatus: UILabel!
    @IBOutlet weak var textFieldPasswordAgain: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    private func validatePassword()->Bool{
        
        let validationResponse = PasswordValidation.validatePassword(password: textfieldPassword.text!, passwordAgain: textFieldPasswordAgain.text!)
        
        if(validationResponse != "OK"){
            labelPasswordStatus.text = validationResponse
            return false
        }
        
        labelPasswordStatus.text = ""
        return true
    }
    

    @IBAction func showCreateUserScreen(_ sender: Any) {
        if validatePassword(){
            self.performSegue(withIdentifier: "passwordTOcreateUser", sender: nil)
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        Log.info(key: "prepare", value: "is Begun")
        
        // Sending Data To CreateUserViewController
        if let createUser = segue.destination as? CreateUserViewController {
            self.signupViewModel.signup.password = self.textfieldPassword.text
            createUser.signupViewModel = self.signupViewModel
            
        }
        
        // Getting Data From DepartmentViewController
        if let faculty = segue.destination as? DepartmentViewController {
            signupViewModel = faculty.signupViewModel
        }
        
        
    }
    
    
    
}
