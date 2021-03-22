//
//  SigninViewController.swift
//  KampusChat
//
//  Created by Burak on 11.02.2021.
//  Copyright © 2021 KampusChat. All rights reserved.
//

import UIKit

class SigninViewController: UIViewController {
   
    
  
    @IBOutlet weak var textFieldUsername: UITextField!
    
    @IBOutlet weak var textFieldPassword: UITextField!
    
    @IBOutlet weak var buttonSignin: UIButton!
    
    @IBOutlet weak var labelUsernameError: UILabel!
    
    @IBOutlet weak var labelPasswordError: UILabel!
    
    private let spinner = SpinnerViewController()
    private let tokenViewModel = TokenViewModel(token: nil,storage: Storage())

    
    private let toast = Toast()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // Progress Dialog
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
    
    
    // Failed Signing in.
    private func showToastMessage(message:String){
        DispatchQueue.main.async {
            Log.info(key: "showToastMessage()",value: "is Begun")
            let toast = Toast()
            toast.showToast(message:message,viewController:self)
        }
        
    }
    
    
    private func validateInputs() -> Bool{
        
        var response = true
        
        // Username
        let usernameValidation = UsernameValidation.validateUsername(username: textFieldUsername.text!)
        
        if(usernameValidation != "OK"){
            
            labelUsernameError.text = usernameValidation
            response = false
            
        } else{
            labelUsernameError.text = ""
        }
        
        // Password
        
        let passwordValidation = PasswordValidation.validatePassword(password: textFieldPassword.text!, passwordAgain: nil)
        
        if(passwordValidation != "OK"){
            
            labelPasswordError.text = passwordValidation
            response = false
            
        } else{
            labelPasswordError.text = ""
        }
        
        return response
      
    }
    
    
    @IBAction func showForgotPassword(_ sender: Any) {
        Log.info(key: "showForgotPassword()",value: "is Begun")
    }
    
    @IBAction func actionSignin(_ sender: Any) {
        Log.info(key: "actionSignin()",value: "is Begun")
        
        if validateInputs(){
            startSpinner()
            signin()
        }
        
    }
    
 
    
    private func showHomeScreen(){
        DispatchQueue.main.async {
            Log.info(key: "showHome()",value: "is Begun")
            self.performSegue(withIdentifier: "signinTOhome", sender: nil)
        }
    }
    
    
    
    private func showEmailScreen(){
        DispatchQueue.main.async {
            Log.info(key: "showEmail()",value: "is Begun")
            self.performSegue(withIdentifier: "signinTOemail", sender: nil)
        }
    }
    
    
    private func signin(){
        Log.info(key: "SigninViewController signin()",value: "is Begun")
        
        let signin = Signin(username: textFieldUsername.text!, password: textFieldPassword.text!)
        let viewModel = SigninViewModel(model:signin)
        
        //Binding
        viewModel.bindViewModelToController = {
            self.token = viewModel.token
            self.error = viewModel.error
        }
    }
    
    
    private var token:Token?{
        didSet{
            stopSpinner()
            if(self.token != nil){
                let viewModel = TokenViewModel(token:self.token,storage: Storage())
                viewModel.saveToken()
            }
        }
    }
    
    private var error:String?{
        didSet{
            
            if(self.error != nil){
                
                if(self.error == "Email adresinizi doğrulamalısınız"){
                    
                    showToastMessage(message: NSLocalizedString("error_confirm_email", comment: ""))
                    showEmailScreen()
                    
                }else if(self.error == "Kullanıcı adı veya şifre hatalı"){
                    
                  showToastMessage(message: NSLocalizedString("error_invalid_credentials", comment: ""))
                
                }else{
                    showToastMessage(message: NSLocalizedString("error_something_went_wrong", comment: ""))
                }
                
            }
            
        }
    }
    
    
}
