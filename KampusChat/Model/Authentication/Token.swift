//
//  Token.swift
//  KampusChat
//
//  Created by Burak on 21.02.2021.
//  Copyright © 2021 KampusChat. All rights reserved.
//

import Foundation

class Token:NSObject{
    
    
    var user_id:Int64
    var token_key:String
    var token_refresh_key:String
    

    init(user_id:Int64, token_key:String, token_refresh_key:String){
        self.user_id = user_id
        self.token_key = token_key
        self.token_refresh_key = token_refresh_key
    }
    
    
}
