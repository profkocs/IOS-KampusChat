//
//  SigninViewController.swift
//  KampusChat
//
//  Created by Burak on 11.02.2021.
//  Copyright © 2021 KampusChat. All rights reserved.
//

import UIKit

class SigninViewController: UIViewController, TokenProtocol {
  
    
   
    
    @IBOutlet weak var textFieldUsername: UITextField!
    
    @IBOutlet weak var textFieldPassword: UITextField!
    
    @IBOutlet weak var buttonSignin: UIButton!
    
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
        
        if(textFieldUsername.text!.count > 2  && textFieldPassword.text!.count > 0){
            return true
        }

        return false
    }
    
    // Progress Dialog
    private func startSpinner(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            Log.info(key: "startSpinner()",value: "is Begun")
            self.spinner.showSpinner(viewController: self)
            
        }
        
    }
    
    private func stopSpinner(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            Log.info(key: "stopSpinner()",value: "is Begun")
            self.spinner.disableSpinner()
            
        }
    }
    
    
    // Failed Signing in.
    private func showToastMessage(message:String){
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
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
    
    
    @IBAction func showSignup(_ sender: Any) {
        Log.info(key: "showSignup()",value: "is Begun")
        //self.performSegue(withIdentifier: "signinTO", sender: nil)
    }
    
    private func showHome(){
        Log.info(key: "showHome()",value: "is Begun")
        self.performSegue(withIdentifier: "signinTOhome", sender: nil)
    }
    
    private func showCode(){
        Log.info(key: "showCode()",value: "is Begun")
        self.performSegue(withIdentifier: "signinTOcode", sender: nil)
    }
    
    
    private func signin(){
        Log.info(key: "SigninViewController signin()",value: "is Begun")
        let signin = Signin(username: textFieldUsername.text!, password: textFieldPassword.text!)
        _ = SigninViewModel(model:signin, tokenProtocol: self)
    }
        
    func handleTokenResponse(token:Token?,error:String?) {
        Log.info(key: "SigninViewController getTokenResponse()",value: "is Begun")
        
        self.token = token
        self.error = error
        
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
                showToastMessage(message: self.error!)
            }
            
        }
    }
    

    
    
}
