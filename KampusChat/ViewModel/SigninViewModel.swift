//
//  SigninViewModel.swift
//  KampusChat
//
//  Created by Burak on 9.03.2021.
//  Copyright © 2021 KampusChat. All rights reserved.
//

/*
 Class Responsibilites ->
 
 - Validating Username and Password
 - Getting Datas From Service
 - Delivering Datas To ViewController
 - Encoding Model for Service Task
 - Making Sign in Action
 
 Class Dependencies ->
 
 - UsernameValidation
 - PasswordValidation
 - Service
 */



import Foundation

class SigninViewModel: AuthViewModel{
    
    
    var model:Signin
    
    private var service:AuthService?
    
    init(model:Signin) {
        
        self.model = model
        self.service = AuthService(viewModel: self)
        
    }
    
    // Validations
    
    private let usernameValidation = UsernameValidation()
    private let passwordValidation = PasswordValidation()
    
    func validateUsername() -> String{
        
       return usernameValidation.validateUsername(username: self.model.username)
    }
    
    func validatePassword() -> String{
    
        return passwordValidation.validatePassword(password: self.model.password, passwordAgain: nil)
    }
    
    // Making Sign in Action
    
    var url = ApiURL.createToken.rawValue
    
    func startAction(){
        
        service?.createPostRequest(url: URL(string: self.url)!)
        
        service?.startTask()
    }
    
    
    // Encoding Model
    func encodeModel() -> Data? {
        do{
           
            return try JSONEncoder().encode(self.model)
            
        } catch {
            
            return nil
        }
    }
    
    // Getting Data From Service
    func getAPIResponse(data: Data?, error: [String]?) {
        
        self.error = error
        self.data = data
    }
    
    // Delivering Data To ViewController
    var bindViewModelToController: (()->()) = {}
    
    var data:Data?{
        
        didSet{
            
            Log.info(key: "SigninViewModel data", value: "didSet")
            
            bindViewModelToController()
        }
    }
    
    var error: [String]?
    
    
    
}
