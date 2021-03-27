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
    
    private let passworValidation = PasswordValidation()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    private func validatePassword()->Bool{
        
        let validationResponse = passworValidation.validatePassword(password: textfieldPassword.text!, passwordAgain: textFieldPasswordAgain.text!)
        
        if(validationResponse != "OK"){
            
            labelPasswordStatus.text = validationResponse
            return false
        }
        
        labelPasswordStatus.text = ""
        return true
    }
    
    private func setPasswordToViewModel(){
        
        self.signupViewModel.model.password = self.textfieldPassword.text
    }
    

    @IBAction func showCreateUserScreen(_ sender: Any) {
        
        if validatePassword(){
            setPasswordToViewModel()
            self.performSegue(withIdentifier: SegueKeys.password_to_createuser.rawValue, sender: nil)
        }
    }

    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        Log.info(key: "prepare", value: "is Begun")
        
        // Sending Data To CreateUserViewController
        if let createUser = segue.destination as? CreateUserViewController {
            
            createUser.signupViewModel = self.signupViewModel
            
        }
        
        // Getting Data From DepartmentViewController
        if let department = segue.destination as? DepartmentViewController {
            
            signupViewModel = department.signupViewModel
        }
        
        
    }
    
    
    
}
