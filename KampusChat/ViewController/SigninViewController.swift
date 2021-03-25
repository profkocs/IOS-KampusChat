//
//  SigninViewController.swift
//  KampusChat
//
//  Created by Burak on 11.02.2021.
//  Copyright © 2021 KampusChat. All rights reserved.
//

import UIKit

/**
Class Responsibility ->
 
 - Showing and Removing Spinner
 - Showing Toast Message
 - Handling UIButton Action
 - Validating Username and Password
 - Starting Signin Action
 - Getting Data and Error From SignViewModel
 - Showing Error Message
 - Creating TokenViewModel and Sending Data To it.
 - Directing another screen.
 
 
Class Dependencies ->
 
 - SpinnerViewController
 - Toast
 - SigninViewModel
 - TokenViewModel
*/


class SigninViewController: UIViewController {
   
    
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
    
    @IBOutlet weak var buttonSignin: UIButton!
    
    @IBAction func actionSignin(_ sender: Any) {
        
        Log.info(key: "actionSignin()",value: "is Begun")
        
        setSigninViewModel()
        
        if(validateUsername() && validatePassword()){
            
            // OK
            startSpinner()
            signin()
        }
        
    }
    
    
    // SigninView Model
    
    private var signinViewModel:SigninViewModel?
    
    private func createModel() -> Signin{
    
       return Signin(username: textFieldUsername.text!, password: textFieldPassword.text!)
    }
    
    private func setSigninViewModel(){
        
        // View Model
        self.signinViewModel = SigninViewModel(model: createModel())
        
        // View Model Binding
        setSigninViewModelBinding()
        
    }
    
    private func setSigninViewModelBinding(){
        
        signinViewModel!.bindViewModelToController = {
            
            Log.info(key: "setSigninViewModelBinding", value: "is Begun")
            
            // Handle Response
            self.handleResponse(data: self.signinViewModel?.data, error: self.signinViewModel?.error)
            
            
            // Spinner
            self.stopSpinner()
            
        }
        
    }
    
    
    
    // Validating Username
    
    @IBOutlet weak var textFieldUsername: UITextField!
    
    @IBOutlet weak var labelUsernameError: UILabel!
    
    private func validateUsername() -> Bool{
        
        let message = signinViewModel?.validateUsername()
        
        if(message == NSLocalizedString("success", comment: "")){
            
            setMessageToUsernameLabel(message: "")
            return true
        }
        
        setMessageToUsernameLabel(message: message!)
        return false
    }
    
    private func setMessageToUsernameLabel(message:String){
        labelUsernameError.text = message
    }
    
    
    
    // Validating Password
    
    @IBOutlet weak var textFieldPassword: UITextField!
    
    @IBOutlet weak var labelPasswordError: UILabel!
    
    private func validatePassword() -> Bool{
        
        let message = signinViewModel?.validatePassword()
        
        if(message == NSLocalizedString("success", comment: "")){
            
            setMessageToPasswordLabel(message: "")
            return true
        }

        setMessageToPasswordLabel(message: message!)
        return false
    }

    private func setMessageToPasswordLabel(message:String){
        labelPasswordError.text = message
    }
    
    
    
    // Starting Signin Action
    private func signin(){
        
        Log.info(key: "SigninViewController signin()",value: "is Begun")
        
        signinViewModel?.signin()
        
    }
    
    
    // Handle Response
    
    
    private func handleResponse(data:Data?, error:[String]?){
        
        if(error != nil){
            
            Log.info(key: "handleResponse", value: "error")
            
            showError(error:error)
            return
        }
        
        setTokenViewModelData(data:data)
    }
    
    private func showError(error:[String]?){
        
        let message = error![0]
        
        showToastMessage(message: message)
        
    }
    
    
    // Token View Model
    
    private var tokenViewModel:TokenViewModel?
    
    private func setTokenViewModelData(data:Data?){
        
        tokenViewModel = TokenViewModel(token: nil)
        
        tokenViewModel!.data = data
        
        tokenViewModel?.saveToken()
    }
   
    
    // Segues
    
    private func showHomeScreen(){
        
        DispatchQueue.main.async {
            
            Log.info(key: "showHomeScreen()",value: "is Begun")
            
            self.performSegue(withIdentifier: SegueKeys.signin_to_home.rawValue, sender: nil)
        }
        
    }
    

    private func showEmailScreen(){
        
        DispatchQueue.main.async {
            
            Log.info(key: "showEmailScreen()",value: "is Begun")
            
            self.performSegue(withIdentifier: SegueKeys.signin_to_email.rawValue, sender: nil)
        }
        
    }
    
    @IBAction func showForgotPasswordScreen(_ sender: Any) {
        
        DispatchQueue.main.async {
            
            Log.info(key: "showForgotPasswordScreen()",value: "is Begun")
            
            self.performSegue(withIdentifier: SegueKeys.sign_to_forgotpassword.rawValue, sender: nil)
        }
        
    }
    
    @IBAction func showCityScreen(_ sender: Any) {
        
        DispatchQueue.main.async {
            
            Log.info(key: "showCityScreen()",value: "is Begun")
            
            self.performSegue(withIdentifier: SegueKeys.signin_to_city.rawValue, sender: nil)
        }
    }
    
 
    
    
}
