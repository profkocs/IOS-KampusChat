//
//  TokenViewModel.swift
//  KampusChat
//
//  Created by Burak on 21.02.2021.
//  Copyright © 2021 KampusChat. All rights reserved.
//

import Foundation

class TokenViewModel{
    
    let keys = ["user_id","token_key","token_refresh_key"]
    var token:Token?
    let storage = Storage()
    
    init(token:Token?){
        
        if(token != nil){
            self.token = token!
        }
    }
    
    var user_id: Int64?{
        return token?.user_id
    }
    
    var token_key: String?{
        return token?.token_key
    }
    
    var token_refresh_key: String?{
        return token?.token_refresh_key
    }
    
    func initilazeToken(){
        let user_id = storage.getInt(key: keys[0])
        
        if user_id != nil {
            
            let token_key = storage.getString(key: keys[1])!
            let token_refresh_key = storage.getString(key: keys[2])!
            token = Token(user_id: user_id!, token_key: token_key, token_refresh_key: token_refresh_key)
        }
    }
    
    func saveToken(){
        storage.saveInt(object: self.user_id!, key: keys[0])
        storage.saveString(object: self.token_key!, key: keys[1])
        storage.saveString(object: self.token_refresh_key!, key: keys[2])
    }
    
    
    
    
    
    
}
