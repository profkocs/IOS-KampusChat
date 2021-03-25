//
//  UsernameValidation.swift
//  KampusChat
//
//  Created by Burak on 20.03.2021.
//  Copyright © 2021 KampusChat. All rights reserved.
//

import Foundation
class UsernameValidation{
    
    
    func validateUsername(username:String)->String{
    
        if((username.count) == 0 || (username.count) < 3){
            
            return NSLocalizedString("error_invalid_username_characters_length", comment: "")
            
        } else if (!(username.unicodeScalars.first!.value >= 97 && username.unicodeScalars.first!.value <= 122)){
            
            return NSLocalizedString("error_username_first_character", comment: "")
        }
    
        return NSLocalizedString("success", comment: "")
    }
    
}
