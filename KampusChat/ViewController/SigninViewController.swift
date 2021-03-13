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
    
    var buttonUsernameFlag = false
    var buttonPasswordFlag = false
    
    private let spinner = SpinnerViewController()
    private let tokenViewModel = TokenViewModel(token: nil)

    
    private let toast = Toast()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // View processes
    private func setButtonasDefault(){
        Log.info(key: "setButtonasDefault()",value: "is Begun")
        buttonSignin.isEnabled = false;
        buttonSignin.alpha = 0.5
    }
    
    private func setButtonasActive(){
        Log.info(key: "setButtonasActive()",value: "is Begun")
        buttonSignin.isEnabled = true;
        buttonSignin.alpha = 1
        buttonSignin.showsTouchWhenHighlighted = true;
    }
   
    
    @IBAction func textFieldUsernameEditingDidChange(_ sender: Any) {
        
        Log.info(key: "textFieldPasswordEditingDidChange()",value: "is Begun")
        if(isUsernameValid() && buttonPasswordFlag){
            setButtonasActive()
        }else{
            setButtonasDefault()
        }
    }
    

    @IBAction func textFieldPasswordDidEnd(_ sender: Any) {
        
        Log.info(key: "textFieldPasswordEditingDidChange()",value: "is Begun")
        if(isPasswordValid() && buttonUsernameFlag){
            setButtonasActive()
        }else{
            setButtonasDefault()
        }
    }
    
    private func isUsernameValid()->Bool{
        
        if(textFieldUsername.text!.count > 2){
            removeUsernameErrorMessage()
            buttonUsernameFlag = true
            return true
        }
            buttonUsernameFlag = false
            showUsernameErrorMessage()
           return false
    }
    
    private func isPasswordValid()->Bool{
        if(textFieldPassword.text!.count > 0){
            removePasswordErrorMessage()
            buttonPasswordFlag = true
            return true
        }
            buttonPasswordFlag = false
            showPasswordErrorMessage()
            return false
        
        
    }
    
    
    private func showUsernameErrorMessage(){
        labelUsernameError.text = NSLocalizedString("invalid_username", comment: "")
    }
    
    private func removeUsernameErrorMessage(){
        labelUsernameError.text = ""
    }
    
    private func showPasswordErrorMessage(){
        labelPasswordError.text = NSLocalizedString("invalid_password", comment: "")
    }
    
    private func removePasswordErrorMessage(){
        labelPasswordError.text = ""
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
    
    
    
    @IBAction func showForgotPassword(_ sender: Any) {
        Log.info(key: "showForgotPassword()",value: "is Begun")
    }
    
    @IBAction func actionSignin(_ sender: Any) {
        Log.info(key: "actionSignin()",value: "is Begun")
        startSpinner()
        signin()
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
                let viewModel = TokenViewModel(token:self.token)
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
