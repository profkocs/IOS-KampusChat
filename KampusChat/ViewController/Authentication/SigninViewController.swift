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
    
    let spinner = SpinnerViewController()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setButtonasDefault()
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
    }
    
    @IBAction func textFieldUsernameEditingDidChange(_ sender: Any) {
        Log.info(key: "textFieldUsernameEditingDidChange()",value: "is Begun")
        if(validateInputs()){
            setButtonasActive()
        }else{
            setButtonasDefault()
        }
    }
    
    @IBAction func textFieldPasswordEditingDidChange(_ sender: Any) {
        Log.info(key: "textFieldPasswordEditingDidChange()",value: "is Begun")
        if(validateInputs()){
            setButtonasActive()
        }else{
            setButtonasDefault()
        }
    }
    
    private func validateInputs()->Bool{
        
        if(textFieldUsername.text!.count > 0 && textFieldPassword.text!.count > 0){
            return true
        }

        return false
    }
   
    
    @IBAction func actionSignin(_ sender: Any) {
        Log.info(key: "actionSignin()",value: "is Begun")
        signin()
        startSpinner()
    }
    
    /**
    @function signin
     Description: It sends inputs to the authentication service
     ,and it gets a message and a response code as a response.
     With that response it determine what to do.
    */
    
    private func signin(){
        Log.info(key: "signin()",value: "is Begun")
        
    }
   
    // Progress Dialog
    private func startSpinner(){
        Log.info(key: "startSpinner()",value: "is Begun")
        spinner.showSpinner(viewController: self)
    }
    
    private func stopSpinner(){
        Log.info(key: "stopSpinner()",value: "is Begun")
        // for test
        // wait two seconds to simulate some work happening
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            // then remove the spinner view controller
            self.spinner.disableSpinner()
        }
        
    }
    
    
    // Failed Signing in.
    private func showToastMessage(message:String){
        Log.info(key: "showToastMessage()",value: "is Begun")
        let toast = Toast()
        toast.showToast(message:message, font:UIFont.systemFont(ofSize: 14) ,viewController:self)
    }
    
    // Succeed Signing in.
    private func saveToken(token:Token){
        Log.info(key: "saveToken()",value: "is Begun")
        let tokenViewModel = TokenViewModel(token: token)
        tokenViewModel.saveToken()
    }
    
    private func showHome(){
         Log.info(key: "showHome()",value: "is Begun")
         self.performSegue(withIdentifier: "signinTOhome", sender: nil)
    }
    
    
    // Sign up
    @IBAction func showSignup(_ sender: Any) {
        Log.info(key: "showSignup()",value: "is Begun")
        self.performSegue(withIdentifier: "signinTOsignupwelcome", sender: nil)
    }
    
    
    
    
}
