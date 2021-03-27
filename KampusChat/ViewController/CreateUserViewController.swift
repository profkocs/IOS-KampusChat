//
//  CreateUserViewController.swift
//  KampusChat
//
//  Created by Burak on 18.03.2021.
//  Copyright © 2021 KampusChat. All rights reserved.
//

/**
 Class Responsibility ->
 
 - Showing and Removing Spinner
 - Showing Toast Message
 - Handling UIButton Action
 - Setting SignupViewModel
 - Validating Username and Email
 - Starting Signup Action
 - Getting Data and Error From SignupViewModel
 - Handling Errors
 - Directing another screen.
 
 
 Class Dependencies ->
 
 - SpinnerViewController
 - Toast
 - SignupViewModel
 */



import UIKit

class CreateUserViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // Showing and Removing Spinner
    
    private let spinner = SpinnerViewController()
    
    private func startSpinner(){
        
        DispatchQueue.main.async {
            
            Log.info(key: "startSpinner()",value: "is Begun")
            
            self.spinner.showSpinner(viewController: self)
        }
        
    }
    
    private func stopSpinner(){
        
        DispatchQueue.main.async {
            
            Log.info(key: "stopSpinner()",value: "is Begun")
            
            self.spinner.disableSpinner()
        }
    }
   
    
    // Showing Toast Message
    
    private let toast = Toast()
    
    private func showToastMessage(message:String){
        
        DispatchQueue.main.async {
            
            Log.info(key: "showToastMessage()",value: "is Begun")
            
            self.toast.showToast(message:message,viewController:self)
        }
        
    }
    
    
    // Handling UIButton Action
    
    @IBAction func signup(_ sender: Any) {
       
        Log.info(key: "actionSignup()",value: "is Begun")
        
        setSignupViewModel()
        
        if(validateUsername() && validatePassword()){
            
            // OK
            startSpinner()
            signup()
        }
        
    }
    
    // Setting SignupViewModel
    
    var signupViewModel:SignupViewModel!
    
    private func setSignupViewModel(){
        
        // View Model
        setUsernameToViewModel()
        setEmailToViewModel()
        
        // View Model Binding
        setSignupViewModelBinding()
        
    }
    
    
    private func setUsernameToViewModel(){
        
        self.signupViewModel.model.userName = textFieldUsername.text
        
    }
    
    private func setEmailToViewModel(){
        
        self.signupViewModel.model.email = textFieldEmail.text
    }
    
    
    private func setSignupViewModelBinding(){
        
        signupViewModel!.bindViewModelToController = {
            
            Log.info(key: "setSignupViewModelBinding", value: "is Begun")
            
            // Handle Response
            self.handleResponse(data: self.signupViewModel?.data, error: self.signupViewModel?.error)
            
            
            // Spinner
            self.stopSpinner()
            
        }
        
    }
    
    
    // Validating Username
    
    
    @IBOutlet weak var textFieldUsername: UITextField!
    
    @IBOutlet weak var labelUsernameStatus: UILabel!
    
    private func validateUsername() -> Bool{
        
        let message = signupViewModel?.validateUsername()
        
        if(message == NSLocalizedString("success", comment: "")){
            
            setMessageToUsernameLabel(message: "")
            return true
        }
        
        setMessageToUsernameLabel(message: message!)
        return false
    }
    
    private func setMessageToUsernameLabel(message:String){
        labelUsernameStatus.text = message
    }
    
    
    // Validating Email
    
    @IBOutlet weak var labelEmailStatus: UILabel!
    @IBOutlet weak var textFieldEmail: UITextField!
    
    private func validatePassword() -> Bool{
        
        let message = signupViewModel?.validateEmail()
        
        if(message!){
            
            setMessageToEmailLabel(message: "")
            return true
        }
        
        setMessageToEmailLabel(message: NSLocalizedString("error_invalid_email", comment: ""))
        return false
    }
    
    private func setMessageToEmailLabel(message:String){
        labelEmailStatus.text = message
    }
    
    
    // Starting Signup Action
    
    private func signup(){
        
        Log.info(key: "SignupViewController signup()",value: "is Begun")
        
        signupViewModel?.startAction()
        
    }
    
    
    // Handle Response
    
    
    private func handleResponse(data:Data?, error:[String]?){
        
        if(error != nil){
            
            Log.info(key: "handleResponse", value: "error")
            
            handleError(errors: error)
            return
        }
        
        showToast(message: NSLocalizedString("account_is_created", comment: ""))
        showSigninScreen()
    }
    
    
    // Handling Errors
    
    private func handleError(errors:[String]?){
        
        for error in errors!{
            
            var value = true
            if(error.contains(AuthServiceKeys.signup_error_username.rawValue)){
                setUsernameStatusLabel()
                value = false
            }
            
            if(error.contains(AuthServiceKeys.signup_error_email.rawValue)){
                setEmailStatusLabel()
                value = false
            }
            
            if(value){
                print(error)
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
    
    
    // Segues
    
    private func showSigninScreen(){
        
        DispatchQueue.main.async {
            
            self.performSegue(withIdentifier: SegueKeys.createuser_to_signin.rawValue, sender: nil)
        }
        
    }
    
    @IBAction func showSignin(_ sender: Any) {
        
        showSigninScreen()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        Log.info(key: "prepare", value: "is Begun")
        
        // Getting Data From PasswordViewController
        if let password = segue.destination as? PasswordViewController {
            signupViewModel = password.signupViewModel
        }
        
        
    }
    
    

}
