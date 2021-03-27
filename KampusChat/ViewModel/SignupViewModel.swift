//
//  SignupViewModel.swift
//  KampusChat
//
//  Created by Burak on 13.03.2021.
//  Copyright © 2021 KampusChat. All rights reserved.
//

/**
 
 Class Responsibilites ->
 
 - Validating Username and Password
 - Getting Datas From Service
 - Delivering Datas To ViewController
 - Making Start Action
 
 Class Dependencies ->
 
 - Service
 
 */



import Foundation
class SignupViewModel:AuthViewModel{
    
    var service: AuthService?
    var model:Signup
    
    init(model:Signup){
        
        self.model = model
        
        service = AuthService(viewModel: self)
        
    }
    
    // Validations
    
    private let usernameValidation = UsernameValidation()
    private let emailValidation = EmailValidation()
    
    func validateUsername() -> String{
        
        return usernameValidation.validateUsername(username: self.model.userName!)
    }
    
    func validateEmail() -> Bool{
        
        return emailValidation.validateEmailAddress(emailAddressString: self.model.email!)
    }
    
    
    // Making Sign up Action
    
    var url = ApiURL.createUser.rawValue
    
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
            
            Log.info(key: "SignupViewModel data", value: "didSet")
            
            bindViewModelToController()
        }
    }
    
    var error: [String]?
    
    
    
}
