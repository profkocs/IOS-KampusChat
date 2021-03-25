//
//  CreateUserViewController.swift
//  KampusChat
//
//  Created by Burak on 18.03.2021.
//  Copyright © 2021 KampusChat. All rights reserved.
//

import UIKit

class CreateUserViewController: UIViewController {

    var signupViewModel:SignupViewModel!
    
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldUsername: UITextField!
    
    @IBOutlet weak var labelUsernameStatus: UILabel!
    
    @IBOutlet weak var labelEmailStatus: UILabel!
    
    private let spinner = SpinnerViewController()
    private let toast = Toast()
    private let usernameValidation = UsernameValidation()
   
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func validateInputs() -> Bool{
        
        var response = true
        // Username
        
        let usernameValidation = self.usernameValidation.validateUsername(username: textFieldUsername.text!)
        if(usernameValidation != "OK"){
            labelUsernameStatus.text = usernameValidation
            response = false
            
        }else{
            labelUsernameStatus.text = ""
        }
        
        if(!EmailValidation.isValidEmailAddress(emailAddressString: textFieldEmail.text!)){
            labelEmailStatus.text = NSLocalizedString("error_invalid_email", comment: "")
            response = false
        }else{
            labelEmailStatus.text = ""
        }
        
        return response
    }
    
    private func prepareViewModel(){
        
        self.signupViewModel.signup.userName = textFieldUsername.text!
        self.signupViewModel.signup.email = textFieldEmail.text!
        
    }
    
    private func showSpinner(){
        DispatchQueue.main.async {
            self.spinner.showSpinner(viewController: self)
        }
    }
    
    private func stopSpinner(){
        DispatchQueue.main.async {
            self.spinner.disableSpinner()
        }
    }
    
   
    
    
    @IBAction func signup(_ sender: Any) {
        if validateInputs(){
            prepareViewModel()
            showSpinner()
            createUser()
        }
    }
    
    @IBAction func showSignin(_ sender: Any) {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "createUserTOsignin", sender: nil)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        Log.info(key: "prepare", value: "is Begun")
        
        // Getting Data From PasswordViewController
        if let password = segue.destination as? PasswordViewController {
            signupViewModel = password.signupViewModel
        }
        
        
    }
    
    private func createUser(){
        signupViewModel.createUser()
        signupViewModel.bindViewModelToController = {
            self.errors = self.signupViewModel.errors
        }
    }
    
    
    private var errors:[String]?{
        
        didSet{
            
            if(errors == nil){
                // success
                Log.info(key: "Create User()", value: "is Succeeded")
            }else{
                
                handleError()
            }
            
            stopSpinner()
        }
        
    }
    
    private func handleError(){
        
        for error in errors!{
            
            var value = true
            if(error.contains(SignupResponseEnum.username.rawValue)){
                setUsernameStatusLabel()
                value = false
            }
            
            if(error.contains(SignupResponseEnum.email.rawValue)){
                setEmailStatusLabel()
                value = false
            }
            
            if(value){
                showToast(message: NSLocalizedString("error_something_went_wrong", comment: ""))
            }
            
        }
        
        
    }
    
    private func setUsernameStatusLabel(){
        DispatchQueue.main.async {
            self.labelUsernameStatus.text = NSLocalizedString("error_username_already_taken", comment: "")
        }
    }
    
    private func setEmailStatusLabel(){
        DispatchQueue.main.async {
            self.labelEmailStatus.text = NSLocalizedString("error_email_already_taken", comment: "")
        }
    }
    
    private func showToast(message:String){
        DispatchQueue.main.async {
            self.toast.showToast(message: NSLocalizedString("error_something_went_wrong", comment: ""), viewController: self)
        }
    }
    
    

}
