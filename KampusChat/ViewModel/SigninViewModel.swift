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
    var tokenProtocol:TokenProtocol
    var service:SigninService;
    
    init(model:Signin, tokenProtocol:TokenProtocol) {
        self.model = model
        self.tokenProtocol = tokenProtocol
        service = SigninService(model:self.model, tokenProtocol: self.tokenProtocol)
    }
    
    var username:String{
        return model.username
    }
    
    var password:String{
        return model.password
    }
    
}
