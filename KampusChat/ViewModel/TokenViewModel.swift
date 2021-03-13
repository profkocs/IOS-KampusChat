//
//  TokenViewModel.swift
//  KampusChat
//
//  Created by Burak on 21.02.2021.
//  Copyright © 2021 KampusChat. All rights reserved.
//

import Foundation

class TokenViewModel{
    
    let keys = ["user_id","accessToken","accessTokenExpiration","refreshToken","refreshTokenExpiration"]
    var token:Token?
    let storage = Storage()
    
    init(){}
    
    init(token:Token?){
        self.token = token

    }
    
    var user_id: String?{
        return token?.user_id
    }
    
    var accessToken: String?{
        return token?.accessToken
    }
    
    var accessTokenExpiration: String?{
        return token?.accessTokenExpiration
    }
    
    var refreshToken:String?{
        return token?.refreshToken
    }
    
    var refreshTokenExpiration:String?{
        return token?.refreshTokenExpiration
    }
    
    /**
 
     func initilazeToken
     description: Getting token which is created after user siggned in and saved to the storage.
     
    */
    
    
    func initilazeToken(){
        
        let user_id = storage.getString(key: keys[0])
        
        if user_id != nil {
            
            let accessToken = storage.getString(key: keys[1])!
            let accessTokenExpiration = storage.getString(key: keys[2])!
            let refreshToken = storage.getString(key: keys[3])!
            let refreshTokenExpiration = storage.getString(key: keys[4])!
            
            token = Token(user_id: user_id!, accessToken: accessToken, accessTokenExpiration: accessTokenExpiration, refreshToken: refreshToken, refreshTokenExpiration: refreshTokenExpiration)
        }
    }
    
    func saveToken(){
        storage.saveString(object: self.user_id!, key: keys[0])
        storage.saveString(object: self.accessToken!, key: keys[1])
        storage.saveString(object: self.accessTokenExpiration!, key: keys[2])
        storage.saveString(object: self.refreshToken!, key: keys[3])
        storage.saveString(object: self.refreshTokenExpiration!, key: keys[4])
    }
    
    
    
    
    
    
}
