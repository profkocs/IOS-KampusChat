//
//  AuthenticationViewModel.swift
//  KampusChat
//
//  Created by Burak on 23.02.2021.
//  Copyright © 2021 KampusChat. All rights reserved.
//

import Foundation
class AuthenticationViewModel{
    
    
    var authentication:Authentication
    
    /**
    @variable input
     Description: It gives the information about which way the user uses to authenticate;
                  email or username.
    */
    var input:String = "username"
    
    init(authentication:Authentication){
        self.authentication = authentication
    }
    
    
    var username:String{
        return authentication.username
    }
    
    var password:String{
        return authentication.password
    }

    func determineInputWay(){
    
        if(EmailValidation.isValidEmailAddress(emailAddressString: self.username)){
            input = "email"
        }
    }
    
    

    
}
