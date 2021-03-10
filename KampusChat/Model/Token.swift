//
//  Token.swift
//  KampusChat
//
//  Created by Burak on 21.02.2021.
//  Copyright © 2021 KampusChat. All rights reserved.
//

import Foundation

class Token:Codable{
    
    
    var user_id:String
    var accessToken:String
    var accessTokenExpiration:String
    var refreshToken:String
    var refreshTokenExpiration:String
    

    init(user_id:String, accessToken:String, accessTokenExpiration:String, refreshToken:String, refreshTokenExpiration:String){
        self.user_id = user_id
        self.accessToken = accessToken
        self.accessTokenExpiration = accessTokenExpiration
        self.refreshToken = refreshToken
        self.refreshTokenExpiration = refreshTokenExpiration
    }
    
    
}
