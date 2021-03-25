//
//  PasswordValidation.swift
//  KampusChat
//
//  Created by Burak on 20.03.2021.
//  Copyright © 2021 KampusChat. All rights reserved.
//

import Foundation
class PasswordValidation{
    
    
    func validatePassword(password:String, passwordAgain:String?)->String{
        
        if(password.count < 6 || password.count > 10){
            return NSLocalizedString("error_invalid_characters_length", comment: "")
        } else if(passwordAgain != nil && password != passwordAgain){
            return NSLocalizedString("error_match_passwords", comment: "")
        }
        return "OK"
    }
    
    
}
