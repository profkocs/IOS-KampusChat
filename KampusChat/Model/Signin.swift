//
//  Signin.swift
//  KampusChat
//
//  Created by Burak on 9.03.2021.
//  Copyright © 2021 KampusChat. All rights reserved.
//

import Foundation
struct Signin:Codable{
    
    var username:String
    var password:String
    
    init(username:String, password:String){
        self.username = username
        self.password = password
    }
    
    
    
}
