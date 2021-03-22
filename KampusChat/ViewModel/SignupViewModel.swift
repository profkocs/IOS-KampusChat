//
//  SignupViewModel.swift
//  KampusChat
//
//  Created by Burak on 13.03.2021.
//  Copyright © 2021 KampusChat. All rights reserved.
//

import Foundation
class SignupViewModel{
    
    var service: SignupService?
    var signup:Signup
    
    init(signup:Signup){
        self.signup = signup
        
    }
    
    func createUser(){
        service = SignupService(model:self.signup)
        service!.bindServiceToViewModel = {
            self.errors = self.service!.errors
        }
    }
    
     var bindViewModelToController: (()->()) = {}
     var errors:[String]?{
        didSet{
            if(errors != nil){
                 print("Yesss 2")
            }
            bindViewModelToController()
        }
    }
    
    
    
}
