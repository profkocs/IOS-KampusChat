//
//  SigninViewModel.swift
//  KampusChat
//
//  Created by Burak on 9.03.2021.
//  Copyright © 2021 KampusChat. All rights reserved.
//

import Foundation
class SigninViewModel{
    
    
    var model:Signin
    var service:SigninService;
    
    var token:Token?{
        didSet{
            bindViewModelToController()
        }
    }
    
    var error:String?
    
    var bindViewModelToController: (()->()) = {}
    
    init(model:Signin) {
        self.model = model
        service = SigninService(model:self.model)
        service.bindServiceToViewModel = {
            self.error = self.service.error
            self.token = self.service.token
        }
    }
    
    var username:String{
        return model.username
    }
    
    var password:String{
        return model.password
    }
    
}
